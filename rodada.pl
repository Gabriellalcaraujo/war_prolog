:- module(rodada, [menuAlocacaoTerritorios/5]).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).
:- use_module(verificaObjetivos).
:- use_module(mapeiaTerritorios).
:- use_module(salvamento).

verificaValidade(Qtd, QtdAdicoes):-
    Lista = [1,2,3,4,5],
    member(Qtd, Lista),
    Qtd =< QtdAdicoes.

temTerritorio(_, []) :- false.
temTerritorio(Jog, [[Jog, Terr] | _]) :- V \= 0, !.
temTerritorio(Elem, [_ | Terr]) :- temTerritorio(Elem, Terr).

primeiroJogador(Mapa, IndiceJogador, R):-
    (temTerritorio -> R = IndiceJogador; Indc1 is IndiceJogador+1, primeiroJogador(Mapa, Indc1, R)).

rodada(NumRodada, JogadoresInfo, Objetivos, IndiceJogador, Mapa, EraSalvo):-
    NovoIndice is (IndiceJogador mod (JogadoresInfo)) +1,
    (\+ temTerritorio -> rodada(NumRodada, JogadoresInfo, Objetivos, NovoIndice, Mapa, 0); 
    (primeiroJogador(Mapa, IndiceJogador, R), IndiceJogador =:= R, NumRodada =\= 1, EraSalvo =:= 0 ->
    repeat,
    writeln("Voce deseja salvar e sair do jogo? Sim (1) Nao (0)"), 
    read_line_to_string(user_input, D),
    ( atom_number(D, N), number(N, [0,1]) -> !;   
        writeln("Entrada inválida :("), fail ), 
    (N =:= 1 ->
    repeat,
    writeln("Escreva o nome do arquivo no qual voce deseja salvar o jogo (obrigatorio ter .txt no fim)"),
    read_line_to_string(user_input, NomeArquivo), salvarJogo([Mapa, JogadoresInfo, Objetivos, NumRodada, IndiceJogador], NomeArquivo);
    define_cor(IndiceJogador), writeln("Vez do jogador ~w"), [IndiceJogador], reset_color),
    )
    
    ),








menuAlocacaoTerritorios(Mapa, IndiceJogador, QtdAdicoes, Objetivos, MapaFinal) :-
    verificaObjetivosRec(Mapa, IndiceJogador, Objetivos),
    imprime_mapa_colorido(Mapa),
    
    format('Voce pode alocar ~w exercitos ~n', [QtdAdicoes]),

    lerTerritorio(Terr),
    
    lerQuantidade(QtdAdicoes, Qtd),

    retornaIndice(Terr, Indice),
    nth1(Indice, Mapa, Sublista),
    novaQtdExercitos(Sublista, Qtd, NovaQtd),
    substituirSublista(Mapa, Indice, [IndiceJogador, NovaQtd], MapaAtt),
    NovaQtdAdicoes is QtdAdicoes - Qtd,
    ( NovaQtdAdicoes > 0 -> 
        menuAlocacaoTerritorios(MapaAtt, IndiceJogador, NovaQtdAdicoes, Objetivos, MapaFinal)
    ;  
        MapaFinal = MapaAtt, imprime_mapa_colorido(MapaFinal)
    ). 

lerQuantidade(QtdAdicoes, Qtd) :-
    write('Quantos exercitos voce deseja adicionar?'), nl,
    read_line_to_codes(user_input, Q),
    string_codes(StringQ, Q),
    atom_string(AtomQtd, StringQ),
    atom_number(AtomQtd, QtdD),
    ( verificaValidade(QtdD, QtdAdicoes) -> Qtd = QtdD
    ; writeln('Entrada invalida!'), lerQuantidade(QtdAdicoes, Qtd) ). 

lerTerritorio(Terr) :-
    writeln('Digite o territorio ao qual voce deseja adicionar (em forma de sigla):'), 
    read_line_to_string(user_input, Entrada),
    ( pertenceMapa(Entrada)  -> Terr = Entrada  % Depois chamar tbm a função que verifica se terr é do jogador
    ; writeln('Entrada invalida!'), lerTerritorio(Terr) ).  % Se inválido, chama recursivamente
