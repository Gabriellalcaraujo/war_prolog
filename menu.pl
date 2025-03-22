verificaOpcao(O):- O = 0; O = 1.
validaJogadores(QtdJog):- 
    Opcoes = [1, 2, 3, 4],
    member(QtdJog, Opcoes).
maxBots(QtdJog, R):- R is 4-QtdJog. 
validaBots(QtdBots, Q):- validaJogadores(QtdBots), QtdBots =< Q, QtdBots >= 1.


menu:-
    write("Você deseja começar um novo jogo (0) ou continuar um jogo salvo (1)?")
    read(Desejo),
    (\+ verificaOpcao(Desejo)-> write("Entrada Inválida :("), menu ; true),
    write("Quantos jogadores terão na partida? (1 a 4):"),
    read(QtdJog),
    (\+ verificaOpcao(Desejo)-> write("Entrada Inválida :(", nl, ), write("Quantos jogadores terão na partida? (1 a 4):"),  ; true),
    qtdBots(QtdJog, R),
    format("Quantos bots seu jogo terá? (~w)~n", [R]),
    read(QtdBots).
