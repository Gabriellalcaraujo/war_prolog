:- module(mostrarObjetivos, [retornaObjetivo/2, atribuir_objetivos/2, retornaObjetivoJog/2]).
:- use_module(library(readutil)).
:- use_module(library(random)).

objetivos([1,2,3,4,5,6]).

retornaObjetivo(Indice, Objetivo):-
    Objetivos = [
    "Conquistar QUATORZE TERRITORIOS a sua escolha.",
    "Conquistar DOZE TERRITORIOS a sua escolha e ocupar cada um deles com pelo menos dois exercitos.",
    "Conquistar na totalidade a AMERICA e a OCEANIA.",
    "Conquistar na totalidade a ASIA e a EUROPA.",
    "Conquistar na totalidade a EUROPA, a OCEANIA e a AFRICA.",
    "Conquistar na totalidade a AMERICA e a EUROPA.",
    "Seu objetivo e fazer com que o JOGADOR 2 seja ELIMINADO. Caso voce seja o jogador dois, seu objetivo passa a ser conquistar QUATORZE TERRITORIOS a sua escolha."
    ],
    nth1(Indice, Objetivos, Objetivo). 

embaralhar_objetivos(Shuffled) :-
    objetivos(List),
    random_permutation(List, Shuffled).

atribuir_objetivos(Qtd, Shuffled) :-
    embaralhar_objetivos(Objetivos),
    Shuffled = Objetivos,
    length(ObjetivosDistribuidos, Qtd), 
    append(ObjetivosDistribuidos, _, Shuffled),  
    distribuir_objetivos(ObjetivosDistribuidos, 1). 

distribuir_objetivos([], _) :-
    writeln("Todos os objetivos foram exibidos.").

distribuir_objetivos([], _).
distribuir_objetivos([H|T], Indice) :-
    format('Pressione ENTER para verificar o objetivo do Jogador ~w.~n', [Indice]),
    get_char(_),
    limpar_tela,
    retornaObjetivo(H, Obj),
    format('Objetivo do Jogador ~w: ~w~n', [Indice, Obj]), nl,
    write("Pressione ENTER"), 
    get_char(_),
    limpar_tela,
    NovoIndice is Indice + 1,
    distribuir_objetivos(T, NovoIndice).

retornaObjetivoJog(IndiceJogador, IndiceObjetivo) :-
    objetivos(ListaObj),
    nth1(IndiceJogador, ListaObj, IndiceObjetivo). 

limpar_tela :- 
    forall(between(1, 50, _), nl),
    flush_output.


