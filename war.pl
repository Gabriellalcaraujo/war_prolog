:- use_module(menu).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).

war:-
    menu(QtdJogF, QtdBotsF),
    QtdJog is QtdJogF + QtdBotsF,
    posicionamento_inicial(QtdJog, NovoMapa),
    mostrarObjetivos:retornaObjetivo(1, Objetivo),
    atribuir_objetivos(QtdJog, Objetivos),
    write(Objetivos), nl,
    write(Objetivo), nl,
    write(QtdJogF), nl,
    write(QtdBotsF), nl,
    write(NovoMapa).