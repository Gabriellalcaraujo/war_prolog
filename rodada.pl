:- module(rodada, [menuAlocacaoTerritorios/5, rodada/7]).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).
:- use_module(verificaObjetivos).
:- use_module(mapeiaTerritorios).
:- use_module(salvamento).
:- use_module(ataque).
:- use_module(movimento).
:- use_module(botJogadas).

ehBot(JogadoresInfo, QtdBots, IndiceJogador):-
    IndicesHumanos is JogadoresInfo - QtdBots,
    IndiceJogador >  IndicesHumanos.

verificaValidade(Qtd, QtdAdicoes):-
    Lista = [1,2,3,4,5],
    member(Qtd, Lista),
    Qtd =< QtdAdicoes.

temTerritorio(_, []) :- false.
temTerritorio(Jog, [[Jog, Terr] | _]) :- Terr \= 0, !.
temTerritorio(Jog, [_ | Terr]) :- temTerritorio(Jog, Terr).

primeiroJogador(Mapa, IndiceJogador, R):-
    (temTerritorio(IndiceJogador, Mapa) -> R = IndiceJogador; Indc1 is IndiceJogador+1, primeiroJogador(Mapa, Indc1, R)).

rodada(NumRodada, JogadoresInfo, QtdBots, Objetivos, IndiceJogador, Mapa, EraSalvo) :-
    NovoIndice is (IndiceJogador mod JogadoresInfo) + 1,
    NumRodadaNovo is NumRodada + 1,

    (\+ temTerritorio(IndiceJogador, Mapa) ->
        rodada(NumRodada, JogadoresInfo, QtdBots, Objetivos, NovoIndice, Mapa, 0);
        
        (primeiroJogador(Mapa, 1, R),
            IndiceJogador =:= R,
            NumRodada =\= 1,
            EraSalvo =:= 0 ->
                repeat,
                writeln("Você deseja salvar e sair do jogo? Sim (1) Não (0)"),
                read_line_to_string(user_input, D),
                (atom_number(D, N), member(N, [0, 1]) -> !;
                    writeln("Opção inválida. Por favor, digite 1 para salvar ou 0 para continuar."), fail),
                
                (N =:= 1 ->
                    repeat,
                    writeln("Escreva o nome do arquivo no qual você deseja salvar o jogo (obrigatório ter .txt no fim)"),
                    read_line_to_string(user_input, NomeArquivo),
                    salvarJogo([Mapa, JogadoresInfo, QtdBots, Objetivos, NumRodada, IndiceJogador], NomeArquivo),
                    halt;
                    define_cor(IndiceJogador),
                    format("Vez do jogador ~w", [IndiceJogador]),
                    reset_color),
                
                (ehBot(JogadoresInfo, QtdBots, IndiceJogador) ->
                    botAloca(Mapa, IndiceJogador, 5, MapaAloc),
                    verificaObjetivosRec(MapaAloc, JogadoresInfo, Objetivos),
                    
                    (NumRodada =< JogadoresInfo ->
                        rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, MapaAloc, 0);
                        botJoga(MapaAloc, JogadoresInfo, IndiceJogador, Objetivos, NovoMapa),
                        rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, NovoMapa, 0));
                        menuAlocacaoTerritorios(Mapa, IndiceJogador, 5, Objetivos, MapaFinal),
                        verificaObjetivosRec(MapaFinal, JogadoresInfo, Objetivos),
                    
                    (NumRodada =< JogadoresInfo ->
                        rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, MapaFinal, 0);
                        inputAtaque(MapaFinal, IndiceJogador, JogadoresInfo, Objetivos, MapaPosAtaq),
                        inputMovimento(MapaPosAtaq, IndiceJogador, JogadoresInfo, [], Objetivos, MapaPosMov),
                        rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, MapaPosMov, 0)));

            define_cor(IndiceJogador),
            format("Vez do jogador ~w~n", [IndiceJogador]),
            reset_color,
            (ehBot(JogadoresInfo, QtdBots, IndiceJogador) ->
                botAloca(Mapa, IndiceJogador, 5, MapaAtt),
                verificaObjetivosRec(MapaAtt, JogadoresInfo, Objetivos),
                (NumRodada =< JogadoresInfo ->
                    rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, MapaAtt, 0);
                    botJoga(MapaAtt, JogadoresInfo, IndiceJogador, Objetivos, NovoMapaB),
                    rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, NovoMapaB, 0));
                    
                menuAlocacaoTerritorios(Mapa, IndiceJogador, 5, Objetivos, MapaF),
                verificaObjetivosRec(MapaF, JogadoresInfo, Objetivos),
                (NumRodada =< JogadoresInfo ->
                    rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, MapaF, 0);
                    inputAtaque(MapaF, IndiceJogador, JogadoresInfo, Objetivos, MapaPosAtaq2),
                    inputMovimento(MapaPosAtaq2, IndiceJogador, JogadoresInfo, [], Objetivos, MapaPosMov2),
                    rodada(NumRodadaNovo, JogadoresInfo, QtdBots, Objetivos, NovoIndice, MapaPosMov2, 0))
            )
        )
    ).


menuAlocacaoTerritorios(Mapa, IndiceJogador, QtdAdicoes, Objetivos, MapaFinal) :-
    verificaObjetivosRec(Mapa, IndiceJogador, Objetivos),
    imprime_mapa_colorido(Mapa),
    format('Voce pode alocar ~w exercitos ~n', [QtdAdicoes]),
    
    repeat,
    writeln('Digite o territorio ao qual voce deseja adicionar (em forma de sigla): '),
    read_line_to_string(user_input, Sigla),
    (pertenceMapa(Sigla), retornaIndice(Sigla, Idc), ehDoJogador(Mapa, Idc, IndiceJogador)->!;
        writeln("Entrada inválida :("), fail),
    
    repeat,
    write('Quantos exercitos voce deseja adicionar?'),
    read_line_to_string(user_input, Qtd),
    ( atom_number(Qtd, QtdAdd), verificaValidade(QtdAdd, QtdAdicoes) -> !; 
        writeln("Entrada inválida :("), fail ),

    nth1(Idc, Mapa, Sublista),
    novaQtdExercitos(Sublista, QtdAdd, NovaQtd),
    substituirSublista(Mapa, Idc, [IndiceJogador, NovaQtd], MapaAtt),
    NovaQtdAdicoes is QtdAdicoes - QtdAdd,
    ( NovaQtdAdicoes > 0 -> 
        menuAlocacaoTerritorios(MapaAtt, IndiceJogador, NovaQtdAdicoes, Objetivos, MapaFinal);  
        MapaFinal = MapaAtt, imprime_mapa_colorido(MapaFinal)). 

