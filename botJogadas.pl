:- module(botJogadas, [botJoga/5, botAtaque/5, botAloca/4]).
:- use_module(mapeiaTerritorios).
:- use_module(utilsAtaque).
:- use_module(ataque).
:- use_module(distribuicaoTerritorios).
:- use_module(verificaObjetivos).
:- use_module(representacaoTerritorios).

botJoga(Mapa, JogInfo, IndiceJogador, Objetivos, NovoMapa) :-
    verificaObjetivosRec(Mapa, JogInfo, Objetivos),
    possibilidadesDeAtaque(Mapa, IndiceJogador, Possibilidades),
    ( Possibilidades == [] -> 
        format("O jogador ~w passou a vez.~n", [IndiceJogador]), 
        imprime_mapa_colorido(Mapa),
        NovoMapa = Mapa
    ; 
        random_member(Acao, [passar, atacar]),
        ( Acao == passar -> 
            format("O jogador ~w decidiu passar a vez.~n", [IndiceJogador]), 
            imprime_mapa_colorido(Mapa),
            NovoMapa = Mapa
        ;   
            format("O jogador ~w decidiu atacar.~n", [IndiceJogador]),
            random_member(Ataque, Possibilidades),
            botAtaque(Mapa, IndiceJogador, Ataque, Objetivos, MapaAposAtaque),
            possibilidadesDeAtaque(MapaAposAtaque, IndiceJogador, NovasPossibilidades),
            ( NovasPossibilidades == [] -> 
                format("O jogador ~w não tem mais ataques disponíveis e passou a vez.~n", [IndiceJogador]),
                imprime_mapa_colorido(Mapa),
                NovoMapa = MapaAposAtaque
            ;   
                botJoga(MapaAposAtaque, JogInfo, IndiceJogador, Objetivos, NovoMapa)
            )
        )
    ).

botAtaque(Mapa, IndiceJogador, Ataque, Objetivos, MapaF) :-
    nth0(0, Ataque, Atacante),
    nth0(1, Ataque, Atacado),
    maxUtilExercitos(Mapa, Atacante, Max),
    nth1(Atacado, Mapa, TerrAtacado),
    nth0(1, TerrAtacado, QtdTerrDef),
    min(QtdTerrDef, QtdDef),
    random_between(1, Max, QtdAtaque),
    QtdDados is QtdAtaque + QtdDef,
    retornaSigla(Atacante, SiglaAtacante),
    retornaSigla(Atacado, SiglaAtacado),
    format("O jogador ~w usou o território ~w para atacar o território ~w utilizando ~w exércitos.~n", [IndiceJogador, SiglaAtacante, SiglaAtacado, QtdAtaque]),
    embaralhar_dados(QtdAtaque, QtdDados, DadosAtac, DadosDef),
    format("DADOS DE ATAQUE: ~w~n", [DadosAtac]),
    format("DADOS DE DEFESA: ~w~n~n", [DadosDef]),
    formataDados(DadosAtac, DadosDef, PerdasAtaq, PerdasDef),
    format("O jogador atacante perdeu ~w exércitos~n", [PerdasAtaq]),
    format("O jogador defensor perdeu ~w exércitos~n", [PerdasDef]),
    batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Atacante, Atacado, NovoMapa),

    (conquistouTerr(NovoMapa, Atacado) ->
        maxUtilExercitos(NovoMapa, Atacante, NovoMax),
        random_between(1, NovoMax, QtdTransf),
        format("O bot conquistou o território e transferiu ~w exércitos para o território conquistado.~n", [QtdTransf]),
        substituirSublista(NovoMapa, Atacado, [IndiceJogador, QtdTransf], MapaAtt),
        jogQtdExercitos(MapaAtt, Atacante, QtdExercitos, _),
        NovaQtdE is QtdExercitos - QtdTransf,
        substituirSublista(MapaAtt, Atacante, [IndiceJogador, NovaQtdE], MapaF)
    ;
        MapaF = NovoMapa
    ).

botAloca(Mapa, IndiceJogador, QtdRestante, NovoMapa) :-
    (
        QtdRestante =:= 0 ->
            imprime_mapa_colorido(Mapa),
            NovoMapa = Mapa
        ;
            findall(Index, (nth1(Index, Mapa, [IndiceJogador, _])), Indices),
            random_member(Territorio, Indices),
            random_between(1, QtdRestante, Qtd),
            retornaSigla(Territorio, SiglaTerritorio),
            format("O jogador ~w (BOT) alocou ~w exércitos no território ~w~n", [IndiceJogador, Qtd, SiglaTerritorio]),
            nth1(Territorio, Mapa, MapaTerr),
            nth0(1, MapaTerr, QtdAntiga),
            NovaQtd is QtdAntiga + Qtd,
            substituirSublista(Mapa, Territorio, [IndiceJogador, NovaQtd], MapaAtualizado),
            NovaQtdRestante is QtdRestante - Qtd,
            botAloca(MapaAtualizado, IndiceJogador, NovaQtdRestante, NovoMapa)
    ).

    


possibilidadesDeAtaque(Mapa, IndiceJ, Possibilidades) :-
    findall([T1, T2], pode_atacar(Mapa, IndiceJ, T1, T2), Possibilidades).


pode_atacar(Mapa, IndiceJ, T1, T2) :-
    nth0(T1_Idx, Mapa, [IndiceJ, Ex1]),
    Ex1 > 1,
    nth0(T2_Idx, Mapa, [OutroJ, _]),
    IndiceJ \= OutroJ,
    T1 is T1_Idx + 1,
    T2 is T2_Idx + 1,
    verificaAdjacencia(T1, T2).




