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
    NovaQtdAtac is Qtd-PerdasAtaq,
    NovaQtdDef is Qtd-PerdasDef,
    substituirSublista(Mapa, Terr, [JogadorAtaq, NovaQtdAtac], NovoMapa),
    substituirSublista(NovoMapa, Alvo, [JogadorDef, NovaQtdDef], MapaAtualizado).
