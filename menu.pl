:- module(menu, [menu/2, verificaOpcao/1]).

verificaOpcao(O):- O = 0; O = 1.

validaJogadores(QtdJog):- 
    Opcoes = [1, 2, 3, 4],
    member(QtdJog, Opcoes).

maxBots(QtdJog, R):- R is 4-QtdJog. 

minBots(QtdJog, Min):- (QtdJog =:= 1 -> Min = 1; Min = 0).

validaBots(QtdBots, Min, Q):- QtdBots >= Min, QtdBots =< Q.

menu(QtdJogF, QtdBotsF):-
    repeat,
    writeln("Quantos jogadores terao na partida? (1 a 4): "), 
    read_line_to_string(user_input, Qtd),
    ( atom_number(Qtd, QtdF), validaJogadores(QtdF) -> QtdJogF = QtdF, !;   
        writeln("Entrada inválida :("), fail 
    ),
    (QtdF = 4 -> QtdBotsF = 0; 
        maxBots(QtdF, R),  
        minBots(QtdF, Min),
        repeat,  
        format("Quantos bots seu jogo tera? (~w a ~w)~n", [Min, R]),  
        read_line_to_string(user_input, QtdB),
    ( atom_number(QtdB, QtdBF), validaBots(QtdBF, Min, R) -> QtdBotsF = QtdBF, !;   
        writeln("Entrada inválida :("), fail
    )).  