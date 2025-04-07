:- set_prolog_flag(encoding, utf8).
:- use_module(menu).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).
:- use_module(rodada).
:- use_module(ataque).
:- use_module(movimento).


war:-
    menu(QtdJogF, QtdBotsF),
    QtdJog is QtdJogF + QtdBotsF,
    posicionamento_inicial(QtdJog, NovoMapa),
    mostrarObjetivos:retornaObjetivo(1, Objetivo),
    atribuir_objetivos(QtdJog, QtdJogF, Objetivos),
    imprime_mapa_colorido(NovoMapa), 
    rodada(1, QtdJog, QtdBotsF, Objetivos, 1, NovoMapa, 0).
