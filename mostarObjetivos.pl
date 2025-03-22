:- use_module(library(readutil)).

clear_screen:-
    shell('clear', _).

objetivos([
    "Conquistar QUATORZE TERRITÓRIOS à sua escolha.",
    "Conquistar DOZE TERRITÓRIOS à sua escolha e ocupar cada um deles com pelo menos dois exércitos.",
    "Conquistar na totalidade a AMÉRICA e a OCEANIA.",
    "Conquistar na totalidade a ÁSIA e a EUROPA.",
    "Conquistar na totalidade a EUROPA, a OCEANIA e a ÁFRICA.",
    "Conquistar na totalidade a AMÉRICA e a EUROPA.",
    "Seu objetivo é fazer com que o JOGADOR 2 seja ELIMINADO. Caso você seja o jogador dois, seu objetivo passa a ser conquistar QUATORZE TERRITÓRIOS à sua escolha."
]). 

expor_objetivo:- 
/passar a quantidade/
    write("Agora vamos mostrar os objetivos. Se prepare!"), nl,
    write("Pressione ENTER para ver os objetivos"), nl,
    read_line_to_codes(user_input, _),
    clear_screen,
    objetivos(Lista),
    /expor_objetivo_rec(seria a quantidade, 1, Lista/
    .

expor_objetivo_rec(_,_,[]):-
    write("Todos os objetivos foram exibidos."), nl,
    write("Pressione ENTER para continuar"), nl,
    read_line_to_codes(user_input, _),
    clear_screen.

/precisa receber a quantidade e um indice/
expor_objetivo_rec(, , [H|T]):-
    (Indice > Qtd -> 
        format("Pressione ENTER para continuar"), nl,
        read_line_to_codes(user_input, _),
        clear_screen,
        format("Todos os objetivos foram exibidos."), nl
    ;
        format("Pressione ENTER para ver o objetivo do jogador ~w", [Indice]), nl,
        read_line_to_codes(user_input, _),
        clear_screen,
        /passar o indice/
        format("Objetivo do jogador ~w", []), nl,
        /o objetivo que estiver na cabeça da lista/
        format("Objetivo: ~w", [H]), nl,
        /passar a quantidade e o indice + 1/
        expor_objetivo_rec(, , T)
    ).
    