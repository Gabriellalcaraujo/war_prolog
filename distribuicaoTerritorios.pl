:- use_module(library(readutil)).
:- use_module(library(random)).

territorios([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]).

mapa([[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]). 

substituirSublista([_|T], 0, NovaSublista, [NovaSublista|T]).

substituirSublista([_|T], Pos, NovaSublista, [_|Resultado]) :- 
    Pos > 0,
    NextPos is Pos - 1,
    substituirSublista(T, NextPos, NovaSublista, Resultado).

embaralhar_territorios(Shuffled) :-
    territorios(List), 
    random_permutation(List, Shuffled).

posicionamento_inicial(Qtd, NovoMapa) :-
    embaralhar_territorios(TerritoriosEmbaralhados),
    mapa(MapaInicial),
    distribuir_territorios(TerritoriosEmbaralhados, 1, Qtd, MapaInicial, NovoMapa).

distribuir_territorios([], _, _, _, Mapa, Mapa). 

distribuir_territorios([H|T], JogadorAtual, Qtd, MapaAtual, NovoMapa) :-,
    substituirSublista(MapaAtual, Index, [JogadorAtual, H], MapaAtualizado),
    ProximoJogador is (JogadorAtual mod Qtd) + 1,
    ProximoIndex is Index + 1,
    distribuir_territorios(T, ProximoJogador, Qtd, MapaAtualizado, NovoMapa).