:- module(utilsAtaque, [ordenaDecrescente/2, calculaPerdas/4, maxUtilExercitos/3, embaralhar_dados/4, min/2, formataDados/4]).
:- use_module(library(random)).

embaralhar_dados(QtdAtac, QtdTotal, DadosAtac, DadosDef):-
    geraDadosAleatorios(QtdTotal, DadosAleatorios),
    take(DadosAleatorios, QtdAtac, DadosAtaque, DadosDefesa),
    ordenaDecrescente(DadosAtaque, DadosAtac),
    ordenaDecrescente(DadosDefesa, DadosDef).

geraDadosAleatorios(0, []) :- !.
geraDadosAleatorios(N, [Elem | Resto]) :-
    N > 0,
    random_between(1, 6, Elem),
    N1 is N - 1,
    geraDadosAleatorios(N1, Resto).

maxUtilExercitos(Mapa, Terr, R):-
    nth1(Terr, Mapa, Sub),
    nth1(2, Sub, QtdExercitos),
    QtdPodeUtil is QtdExercitos-1,
    min(QtdPodeUtil, R).

min(Qtd, R):-
    (Qtd < 3 -> R is Qtd; R is 3).

formataDados(L1, L2, PerdasAtaq, PerdasDef) :-  
    length(L1, R1),  
    length(L2, R2),  
    R1 == R2,
    calculaPerdas(L1, L2, PerdasAtaq, PerdasDef).

% Se a quantidade de dados do atacante e do defensor forem diferentes, manipula L2 pra ficar do mesmo tamanho de L1
formataDados(L1, L2, PerdasAtaq, PerdasDef):-
    length(L1, R1),
    length(L2, R2),
    (R1 < R2 -> 
    take(L2, R1, L2F, _), calculaPerdas(L1, L2F, PerdasAtaq, PerdasDef);
    take(L1, R2, L1F, _), calculaPerdas(L1F, L2, PerdasAtaq, PerdasDef)).


% O resto da lista importa paga pegarmos os dados do defensor
take(L, QtdTake, Lfinal, Resto):-
    length(Lfinal, QtdTake),
    append(Lfinal, Resto, L).

ordenaDecrescente(L, Ordenada):-
    msort(L, R),
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

