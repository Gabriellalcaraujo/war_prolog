:- use_module(distribuicaoTerritorios).
:- use_module(utilsAtaque).

ataque(Mapa, Terr, Alvo, QtdAtaq, DadosAtac, DadosDef):-
    ordenaDecrescente(DadosAtac, R),
    ordenaDecrescente(DadosDef, R2),
    calculaPerdas(DadosAtac, DadosDef, PerdasAtaq, PerdasDef),
    batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo).

batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo):-
    jogQtdExercitos(Mapa, Terr, QtdAtaq, JogadorAtaq),
    jogQtdExercitos(Mapa, Alvo, QtdDef, JogadorDef),
    NovaQtdAtac is QtdAtaq-PerdasAtaq,
    NovaQtdDef is QtdDef-PerdasDef,
    substituirSublista(Mapa, Terr, [JogadorAtaq, NovaQtdAtac], NovoMapa),
    substituirSublista(NovoMapa, Alvo, [JogadorDef, NovaQtdDef], MapaAtualizado),
    write(MapaAtualizado).

main :- 
    batalhaMapa([[1,5],[1,6],[1,6],[2,4],[2,7]], 3, 2, 1, 4). 
    