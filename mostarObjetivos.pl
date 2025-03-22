:- use_module(library(readutil)).
:- use_module(library(random)).

objetivos([
    "Conquistar QUATORZE TERRITORIOS a sua escolha.",
    "Conquistar DOZE TERRITORIOS a sua escolha e ocupar cada um deles com pelo menos dois exercitos.",
    "Conquistar na totalidade a AMERICA e a OCEANIA.",
    "Conquistar na totalidade a ASIA e a EUROPA.",
    "Conquistar na totalidade a EUROPA, a OCEANIA e a AFRICA.",
    "Conquistar na totalidade a AMERICA e a EUROPA.",
    "Seu objetivo e fazer com que o JOGADOR 2 seja ELIMINADO. Caso voce seja o jogador dois, seu objetivo passa a ser conquistar QUATORZE TERRITORIOS a sua escolha."
]).

embaralhar_objetivos(Shuffled) :-
    objetivos(List),
    random_permutation(List, Shuffled).

atribuir_objetivos(Qtd) :-
    embaralhar_objetivos(Shuffled),
    length(ObjetivosDistribuidos, Qtd), 
    append(ObjetivosDistribuidos, _, Shuffled),  
    distribuir_objetivos(ObjetivosDistribuidos, 1). 

distribuir_objetivos([], _) :-
    writeln("Todos os objetivos foram exibidos.").

distribuir_objetivos([], _).
distribuir_objetivos([H|T], Indice) :-
    format('Pressione ENTER para verificar o objetivo do Jogador ~w.~n', [Indice]),
    get_char(_),
    format('Objetivo do Jogador ~w: ~w~n', [Indice, H]), nl,
    NovoIndice is Indice + 1,
    distribuir_objetivos(T, NovoIndice).

