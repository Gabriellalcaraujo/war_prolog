:- module(distribuicaoTerritorios, [posicionamento_inicial/2, novaQtdExercitos/3, substituirSublista/4, ehDoJogador/3, jogQtdExercitos/4]).
:- use_module(library(readutil)).
:- use_module(library(random)).

territorios([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]).

mapa([[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]). 

substituirSublista([_|T], 1, NovaSublista, [NovaSublista|T]).
substituirSublista([H|T], Pos, NovaSublista, [H|Resultado]) :- 
    Pos > 1,
    NextPos is Pos - 1,
    substituirSublista(T, NextPos, NovaSublista, Resultado).

embaralhar_territorios(Shuffled) :-
    territorios(List), 
    random_permutation(List, Shuffled).

posicionamento_inicial(Qtd, NovoMapa) :-
    embaralhar_territorios(TerritoriosEmbaralhados),
    mapa(MapaInicial),
    distribuir_territorios(TerritoriosEmbaralhados, MapaInicial, Qtd, 1, NovoMapa).

distribuir_territorios([], MapaAtualizado, _, _, MapaAtualizado). 
distribuir_territorios([H|T], Mapa, Qtd, Ind, NovoMapa) :-
    determinaJogador(Qtd, Ind, R),
    substituirSublista(Mapa, H, [R, 1], MapaAtualizado),
    Ind1 is Ind+1,
    distribuir_territorios(T, MapaAtualizado, Qtd, Ind1, NovoMapa).
    
determinaJogador(Qtd, Ind, R):-
    determinaJogadorRec(Qtd, Ind, 1, R).

determinaJogadorRec(Qtd, Idc, Njogador, R):-
    Nterr is 24//Qtd,
    (Nterr*Njogador >= Idc -> R = Njogador; Njogador1 is Njogador+1, determinaJogadorRec(Qtd, Idc, Njogador1, R)). 

novaQtdExercitos(Sublista, Qtd, NovaQtd) :-
    nth0(1, Sublista, Resultado),
    NovaQtd is Qtd + Resultado.

jogQtdExercitos(Mapa, Terr, Qtd, Jogador):-
    nth1(Terr, Mapa, Sublista),
    nth1(2, Sublista, Qtd),
    nth1(1, Sublista, Jogador).


ehDoJogador(Mapa, Terr, Jogador):-
    nth1(Terr, Mapa, Sublista),
    nth1(1, Sublista, JogadorT),
    Jogador =:= JogadorT.


