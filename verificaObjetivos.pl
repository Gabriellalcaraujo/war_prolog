:- module(verificaObjetivos, [verificaObjetivos/3]).

verificaObjetivos(Mapa, IndiceJogador, 1) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios),
    length(Territorios, R), R >= 14.

verificaObjetivos(Mapa, IndiceJogador, 2) :-
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, Exercitos]), Exercitos >= 2), Territorios),
    length(Territorios, R), R >= 12. 

verificaObjetivos(Mapa, IndiceJogador, 3) :-
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [0, 1, 2, 3, 4, 5, 6, 22, 23]. 

verificaObjetivos(Mapa, IndiceJogador, 4) :- 
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [7, 8, 9, 10, 15, 16, 17, 18, 19, 20, 21].

verificaObjetivos(Mapa, IndiceJogador, 5) :-
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [7, 8, 9, 11, 12, 13, 14, 22, 23].

verificaObjetivos(Mapa, IndiceJogador, 6) :-
    findall(Indice, 
            (nth0(Indice, Mapa, [IndiceJogador, _])), Territorios), 
    Territorios = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].
 



    
    

