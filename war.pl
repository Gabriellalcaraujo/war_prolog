:- set_prolog_flag(encoding, utf8).
:- use_module(menu).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).


war:-
    menu(QtdJogF, QtdBotsF),
    QtdJog is QtdJogF + QtdBotsF,
    posicionamento_inicial(QtdJog, NovoMapa),
    mostrarObjetivos:retornaObjetivo(1, Objetivo),
    atribuir_objetivos(QtdJog, Objetivos),
    imprime_mapa_colorido(NovoMapa),
    write(Objetivos), nl,
    write(Objetivo), nl,
    write(QtdJogF), nl,
    write(QtdBotsF), nl,
    write(NovoMapa).