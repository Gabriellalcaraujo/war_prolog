:- set_prolog_flag(encoding, utf8).
:- use_module(menu).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).
:- use_module(rodada).




war:-
    menu(QtdJogF, QtdBotsF),
    QtdJog is QtdJogF + QtdBotsF,
    posicionamento_inicial(QtdJog, NovoMapa),
    mostrarObjetivos:retornaObjetivo(1, Objetivo),
    atribuir_objetivos(QtdJog, Objetivos),
    imprime_mapa_colorido(NovoMapa), 
    menuAlocacaoTerritorios(NovoMapa, 1, 5, Objetivos, MapaFinal), nl,
    write(MapaFinal).
