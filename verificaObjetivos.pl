:- module(verificaObjetivos, [verificaObjetivosRec/3]).
:- use_module(rodada).

verificaObjetivosRec(_, _,_).
verificaObjetivosRec(Mapa, QtdJog, Objetivos):-
    QtdJog >= 1,
    nth1(QtdJog, Objetivos, Objetivo),
    verificaObjetivos(Mapa, QtdJog, Objetivo),
    QtdJog1 is QtdJog-1, 
    verificaObjetivosRec(Mapa, QtdJog1, Objetivos).

% Predicado para o objetivo 1
verificaObjetivos(Mapa, IndiceJogador, 1) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios),
    length(Territorios, R), R >= 14.

% Predicado para o objetivo 2
verificaObjetivos(Mapa, IndiceJogador, 2) :-
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, Exercitos]), Exercitos >= 2), Territorios),
    length(Territorios, R), R >= 12.

% Predicado para o objetivo 3
verificaObjetivos(Mapa, IndiceJogador, 3) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [0, 1, 2, 3, 4, 5, 6, 22, 23].

% Predicado para o objetivo 4
verificaObjetivos(Mapa, IndiceJogador, 4) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [7, 8, 9, 10, 15, 16, 17, 18, 19, 20, 21].

% Predicado para o objetivo 5
verificaObjetivos(Mapa, IndiceJogador, 5) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [7, 8, 9, 11, 12, 13, 14, 22, 23].

% Predicado para o objetivo 6
verificaObjetivos(Mapa, IndiceJogador, 6) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].

% Predicado para o objetivo 7
verificaObjetivos(Mapa, IndiceJogador, 7) :-
    (IndiceJogador =:= 2 -> verificaObjetivos(Mapa, 2, 1); /+ temTerritorio(IndiceJogador, Mapa)).

verificaObjetivos(_, _, _).
