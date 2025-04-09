:- module(verificaObjetivos, [verificaObjetivosRec/3]).
:- use_module(rodada).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).

verificaObjetivosRec(_, 0,_).
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
    length(Territorios, R), R >= 14,
    objetivoAlcancado(IndiceJogador, 1).


% Predicado para o objetivo 2
verificaObjetivos(Mapa, IndiceJogador, 2) :-
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, Exercitos]), Exercitos >= 2), Territorios),
    length(Territorios, R), R >= 12,
    objetivoAlcancado(IndiceJogador, 2).


% Predicado para o objetivo 3
verificaObjetivos(Mapa, IndiceJogador, 3) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), TerritoriosJog),
    writeln(TerritoriosJog),
    TerritoriosObj = [0, 1, 2, 3, 4, 5, 6, 22, 23],
    esta_contida(TerritoriosObj, TerritoriosJog),
    objetivoAlcancado(IndiceJogador, 3).


% Predicado para o objetivo 4
verificaObjetivos(Mapa, IndiceJogador, 4) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), TerritoriosJog), 
    TerritoriosObj = [7, 8, 9, 10, 15, 16, 17, 18, 19, 20, 21],
    esta_contida(TerritoriosObj, TerritoriosJog),
    objetivoAlcancado(IndiceJogador, 4).


% Predicado para o objetivo 5
verificaObjetivos(Mapa, IndiceJogador, 5) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), TerritoriosJog), 
    TerritoriosObj = [7, 8, 9, 11, 12, 13, 14, 22, 23],
    esta_contida(TerritoriosObj, TerritoriosJog),
    objetivoAlcancado(IndiceJogador, 5).


% Predicado para o objetivo 6
verificaObjetivos(Mapa, IndiceJogador, 6) :- 
    writeln("entrei aqui"),
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), TerritoriosJog), 
    TerritoriosObj = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    esta_contida(TerritoriosObj, TerritoriosJog),
    objetivoAlcancado(IndiceJogador, 6).


% Predicado para o objetivo 7
verificaObjetivos(Mapa, IndiceJogador, 7) :-
    (IndiceJogador =:= 2 -> verificaObjetivos(Mapa, 2, 1); \+ temTerritorio(2, Mapa)),
    objetivoAlcancado(IndiceJogador, 7).

verificaObjetivos(_, _, _).

objetivoAlcancado(IndiceJogador, IdcObjetivo):-
    retornaObjetivo(IdcObjetivo, Objetivo),
    define_cor(IndiceJogador),
    format("O jogador ~w ganhou!~n", [IndiceJogador]),
    format("Objetivo de ~w alcançado!~n", [Objetivo]),
    halt.

esta_contida([], _).
esta_contida([X|Xs], B) :-
    member(X, B),
    esta_contida(Xs, B).


territorios(["AL", "CA", "GL", "NY", "MX", "BR", "AR", "UK", "GE", "SP", 
              "TU", "MR", "EG", "SA", "MA", "MO", "SI", "VL", "CH", "JP", 
              "IN", "VI", "AU", "NZ"]).
%                  AL    CA    GL    NY    MX    BR   AR    UK    GE     SP    TU    MR   EG     SA    MA   MO    SI     VL    CH    JP    IN      VI    AU    NZ
%                  1     2     3     4     5     6     7    8      9     10    11    12   13     14    15   16    17     18    19    20    21      22    23    24
%Mapas de teste [[1,4],[1,3],[1,3],[1,2],[1,1],[1,3],[1,2],[1,1],[1,1],[1,1],[3,1],[4,4],[3,2],[2,3],[4,1],[3,2],[2,9],[1,18],[2,1],[2,9],[3,25],[4,10],[2,2],[1,1]]
%               [[1,4],[4,3],[1,3],[3,2],[1,1],[1,3],[1,2],[3,1],[1,1],[1,1],[3,1],[4,4],[3,2],[1,3],[4,1],[3,2],[4,9],[1,18],[4,1],[3,9],[3,25],[4,10],[4,2],[1,1]]
%               [[1,4],[2,3],[2,3],[3,2],[2,1],[2,3],[1,2],[2,1],[2,1],[1,1],[2,1],[2,4],[3,2],[2,3],[2,1],[3,2],[2,9],[2,18],[4,1],[2,9],[3,25],[2,10],[4,2],[1,1]]
%               [[1,4],[2,3],[2,3],[3,2],[2,1],[2,3],[1,2],[2,1],[2,1],[1,1],[2,1],[2,4],[3,2],[2,3],[2,1],[3,2],[2,9],[2,18],[4,1],[2,9],[3,25],[2,10],[4,2],[1,1]]
%               [[1,4],[1,3],[1,3],[1,2],[1,1],[1,3],[1,2],[2,1],[2,1],[1,1],[2,1],[2,4],[3,2],[2,3],[2,1],[3,2],[2,9],[2,18],[4,1],[2,9],[3,25],[2,10],[1,2],[1,1]]
%TESTEI ATÉ O 3

mainObjetivos :-
    Mapa = [[3,4],[3,3],[3,3],[3,2],[3,1],[3,3],[3,2],[2,1],[2,1],[1,1],[2,1],[2,4],[3,2],[2,3],[2,1],[3,2],[2,9],[2,18],[4,1],[2,9],[3,25],[2,10],[3,2],[3,1]],
    verificaObjetivosRec(Mapa, 4, [1,1,3,4]).

%america e europa deu erro
