:- module(rodada, [menuAlocacaoTerritorios/5]).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).
:- use_module(verificaObjetivos).
:- use_module(mapeiaTerritorios).

verificaValidade(Qtd, QtdAdicoes):-
    Lista = [1,2,3,4,5],
    member(Qtd, Lista),
    Qtd =< QtdAdicoes.


menuAlocacaoTerritorios(Mapa, IndiceJogador, QtdAdicoes, Objetivos, MapaFinal) :-
    nth1(IndiceJogador, Objetivos, Objetivo),
    verificaObjetivos(Mapa, IndiceJogador, Objetivo),
    imprime_mapa_colorido(Mapa),
    format('Voce pode alocar ~w exercitos ~n', [QtdAdicoes]),

    lerTerritorio(Terr),
    
    lerQuantidade(Qtd, QtdAdicoes),

    retornaIndice(Terr, Indice),
    write(Indice),
    nth0(Indice, Mapa, Sublista),
    novaQtdExercitos(Sublista, Qtd, NovaQtd),
    substituirSublista(Mapa, Indice, [IndiceJogador, NovaQtd], MapaAtt),
    NovaQtdAdicoes is QtdAdicoes - Qtd,
    ( NovaQtdAdicoes > 0 -> 
        menuAlocacaoTerritorios(MapaAtt, IndiceJogador, NovaQtdAdicoes, Objetivos, MapaFinal)
    ;  
        MapaFinal = MapaAtt  % Se terminou as alocações, retorna o mapa atualizado
    ). 

lerQuantidade(Qtd, QtdAdicoes) :-
    write('Quantos exercitos voce deseja adicionar?'), nl,
    read_line_to_codes(user_input, Q),
    string_codes(StringQ, Q),
    atom_string(AtomQtd, StringQ),
    atom_number(AtomQtd, Qtd),
    ( verificaValidade(Qtd, QtdAdicoes) -> true
    ; writeln('Entrada invalida!'), lerQuantidade(Qtd, QtdAdicoes) ). 

lerTerritorio(Terr) :-
    writeln('Digite o territorio ao qual voce deseja adicionar (em forma de sigla):'), 
    read_line_to_string(user_input, Entrada),
    ( pertenceMapa(Entrada) -> Terr = Entrada
    ; writeln('Entrada invalida!'), lerTerritorio(Terr) ).  % Se inválido, chama recursivamente
