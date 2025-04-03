:- module(utilsAtaque, [ordenaDecrescente/2, calculaPerdas/4]).
:- use_module(library(random)).

dados([1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6]).

embaralhar_dados(Shuffled):-
    dados(List),
    randompermutation(List, Shuffled).

maxUtilExercitos(Mapa, Terr, R):-
    nth1(Terr, Mapa, Sub),
    nth1(2, Sub, QtdExercitos),
    QtdPodeUtil is QtdExercitos-1,
    min(QtdPodeUtil, R).

min(Qtd, R):-
    (Qtd < 3 -> R is Qtd; R is 3).

dadosDefesa(L1, L2, L2) :-  
    length(L1, R1),  
    length(L2, R2),  
    R1 == R2.

% Se a quantidade de dados do atacante e do defensor forem diferentes, manipula L2 pra ficar do mesmo tamanho de L1
dadosDefesa(L1, L2, L2F):-
    length(L1, R1),
    length(L2, R2),
    (R1 < R2 -> 
    take(L2, R1, L2F, N);
    QtdZeros is R1-R2,
    addZeros(L2, QtdZeros, L2F)
    ).

dadosAtaque(L1, L2, L1) :-  
    length(L1, R1),  
    length(L2, R2),  
    R1 == R2.

% Se a quantidade de dados do defensor e do atacante forem diferentes, manipula L1 pra ficar do mesmo tamanho de L2
dadosAtaque(L1, L2, L1F):-
    length(L1, R1),
    length(L2, R2),
    (R1 < R2 -> 
    QtdZeros is R2-R1,
    addZeros(L1, QtdZeros, L1F);
    take(L1, R2, L1F, N)
    ).

addZeros(L, QtdZeros, Lfinal):-
    length(Aux, QtdZeros),
    maplist(=(0), Aux),
    append(L, Aux, Lnova).

take(L, QtdTake, Lfinal, N):-
    length(Lfinal, QtdTake),
    append(Lfinal, N, L).

ordenaDecrescente(L, Ordenada):-
    sort(L, R),
    reverse(R, Ordenada).

calculaPerdas([], [], 0, 0).
calculaPerdas([H|T], [H2|T2], PerdasAtaq, PerdasDef):-
    H > H2,
    calculaPerdas(T, T2, PerdasAtaq, PerdasDef1),
    PerdasDef is PerdasDef1+1.

calculaPerdas([H|T], [H2|T2], PerdasAtaq, PerdasDef):-
    H =< H2,
    calculaPerdas(T, T2, PerdasAtaq2, PerdasDef),
    PerdasAtaq is PerdasAtaq2+1.

main:- 
    calculaPerdas([3,5,3], [4,4,1], PerdasAtaq, PerdasDef),
    writeln(PerdasAtaq),
    writeln(PerdasDef).