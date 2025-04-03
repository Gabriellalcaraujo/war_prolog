:- module(menu, [menu/2, verificaOpcao/1]).

verificaOpcao(O):- O = 0; O = 1.
validaJogadores(QtdJog):- 
    Opcoes = [1, 2, 3, 4],
    member(QtdJog, Opcoes).

maxBots(QtdJog, R):- R is 4-QtdJog. 

validaBots(QtdBots, Q):- QtdBots >= 0, QtdBots =< Q.

menu(QtdJogF, QtdBotsF):-
    repeat,
    writeln("Voce deseja comecar um novo jogo (0) ou continuar um jogo salvo (1)?"),
    read_line_to_string(user_input, D),
    ( atom_number(D, N), verificaOpcao(N) -> !;   
        writeln("Entrada inválida :("), fail 
    ),
    repeat,
    writeln("Quantos jogadores terao na partida? (1 a 4): "), 
    read_line_to_string(user_input, Qtd),
    ( atom_number(Qtd, QtdF), validaJogadores(QtdF) -> QtdJogF = QtdF, !;   
        writeln("Entrada inválida :("), fail 
    ),
    (QtdF = 4 -> QtdBotsF = 0; 
        maxBots(QtdF, R),  
        repeat,  
        format("Quantos bots seu jogo tera? (0 a ~w)~n", [R]),  
        read_line_to_string(user_input, QtdB),
    ( atom_number(QtdB, QtdBF), validaBots(QtdBF, R) -> QtdBotsF = QtdBF, !;   
        writeln("Entrada inválida :("), fail
    )).  