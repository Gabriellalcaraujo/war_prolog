
verificaOpcao(O):- O = 0; O = 1.
validaJogadores(QtdJog):- 
    Opcoes = [1, 2, 3, 4],
    member(QtdJog, Opcoes).
maxBots(QtdJog, R):- R is 4-QtdJog. 
validaBots(QtdBots, Q):- validaJogadores(QtdBots), QtdBots =< Q.


menu:-
    format("Voce deseja comecar um novo jogo (0) ou continuar um jogo salvo (1)?"),nl,
    read_line_to_codes(user_input, D),
    string_codes(String, D),
    atom_string(AtomDesejo, String),  
    atom_number(AtomDesejo, Desejo),
    (\+ verificaOpcao(Desejo)-> write("Entrada Invalida :("),nl, menu ; true),
    repeat,
    write("Quantos jogadores terao na partida? (1 a 4): "), nl,
    read_line_to_codes(user_input, Q),
    string_codes(StringQ, Q),
    atom_string(AtomQtdJog, StringQ),
    atom_number(AtomQtdJog, QtdJog),
    (validaJogadores(QtdJog) -> ! ; write("Entrada Invalida! :("), nl, fail),
    maxBots(QtdJog, R),
    repeat,
    format("Quantos bots seu jogo tera? (~w)~n", [R]),
    read_line_to_codes(user_input, QB),
    string_codes(StringQB, QB),
    atom_string(AtomQtdBots, StringQB),
    atom_number(AtomQtdBots, QtdBots),
    (validaBots(QtdBots, R) -> ! ; write("Entrada Invalida! :("), nl, fail).
