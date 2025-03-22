verificaOpcao(O):- O = 0; O = 1.
validaJogadores(QtdJog):- 
    Opcoes = [1, 2, 3, 4],
    member(QtdJog, Opcoes).
maxBots(QtdJog, R):- R is 4-QtdJog. 
validaBots(QtdBots, Q):- validaJogadores(QtdBots), QtdBots =< Q.


menu:-
    write("Você deseja começar um novo jogo (0) ou continuar um jogo salvo (1)?"),
    read(Desejo),
    (\+ verificaOpcao(Desejo)-> write("Entrada Inválida :("), menu ; true),
    repeat,
    write("Quantos jogadores terão na partida? (1 a 4): "), nl,
    read(QtdJog),
    (validaJogadores(QtdJog) -> ! ; write("Entrada Inválida! Tente novamente."), nl, fail),
    maxBots(QtdJog, R),
    repeat,
    format("Quantos bots seu jogo terá? (~w)~n", [R]),
    read(QtdBots),
    (validaBots(QtdBots, R) -> ! ; write("Entrada Inválida! Tente novamente."), nl, fail).
