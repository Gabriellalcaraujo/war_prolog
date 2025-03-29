:- use_module(menu).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).

war:-
    menu(QtdJogF, QtdBotsF),
    QtdJog is QtdJogF + QtdBotsF,
    posicionamento_inicial(QtdJog, NovoMapa),
    atribuir_objetivos(QtdJog, Objetivos), nl,
    write(QtdJogF), nl,
    write(QtdBotsF), nl,
    write(NovoMapa), nl,
    write(Objetivos).