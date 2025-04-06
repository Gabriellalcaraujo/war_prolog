:- use_module(mapeiaTerritorios).
:- use_module(utilsAtaque).
:- use_module(ataque).
:- use_module(distribuicaoTerritorios).

botJoga(Mapa, JogInfo, IndiceJogador, Objetivos, NovoMapa) :-
    possibilidadesDeAtaque(Mapa, IndiceJogador, Possibilidades),
    ( Possibilidades == [] -> 
        format("O jogador ~w passou a vez.~n", [IndiceJogador]), 
        NovoMapa = Mapa
    ; 
        random_member(Acao, [passar, atacar]),
        ( Acao == passar -> 
            format("O jogador ~w decidiu passar a vez.~n", [IndiceJogador]), 
            NovoMapa = Mapa
        ;   
            format("O jogador ~w decidiu atacar.~n", [IndiceJogador]),
            random_member(Ataque, Possibilidades),
            botAtaque(Mapa, IndiceJogador, Ataque, Objetivos, MapaAposAtaque),
            possibilidadesDeAtaque(MapaAposAtaque, IndiceJogador, NovasPossibilidades),
            ( NovasPossibilidades == [] -> 
                format("O jogador ~w não tem mais ataques disponíveis e passou a vez.~n", [IndiceJogador]), 
                NovoMapa = MapaAposAtaque
            ;   
                botJoga(MapaAposAtaque, JogInfo, IndiceJogador, Objetivos, NovoMapa)
            )
        )
    ).

botAtaque(Mapa, IndiceJogador, Ataque, Objetivos, MapaF) :-
    nth0(0, Ataque, Atacante),
    writeln(Atacante), %log check
    nth0(1, Ataque, Atacado),
    writeln(Atacado), %log check
    maxUtilExercitos(Mapa, Atacante, Max),
    writeln(Max), %log check
    nth1(Atacado, Mapa, TerrAtacado),
    writeln(TerrAtacado), %log check
    nth0(1, TerrAtacado, QtdTerrDef),
    writeln(QtdTerrDef), %log check
    min(QtdTerrDef, QtdDef),
    writeln(QtdDef), %log
    random_between(1, Max, QtdAtaque),
    writeln(QtdAtaque), %log
    QtdDados is QtdAtaque + QtdDef,
    writeln(QtdDados), %log
    format("O jogador ~w usou o território ~w para atacar o território ~w utilizando ~w exércitos.~n", [IndiceJogador, Atacante, Atacado, QtdAtaque]),
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
        QtdRestante =:= 0 -> NovoMapa = Mapa;
        findall(Index, (nth1(Index, Mapa, [IndiceJogador, _])), Indices),
        random_member(Territorio, Indices),
        random_between(1, QtdRestante, Qtd),
        format("O jogador ~w (BOT) alocou ~w exércitos no território ~w", [IndiceJogador, Qtd, Territorio]),
        nth1(Territorio, Mapa, MapaTerr),
        nth0(1, MapaTerr, QtdAntiga),
        NovaQtd is QtdAntiga + Qtd,
        substituirSublista(Mapa, Territorio, [IndiceJogador, NovaQtd], NovoMapa),
        NovaQtdRestante is QtdRestante - Qtd,
        botAloca(NovoMapa, IndiceJogador, NovaQtdRestante, NovissimoMapa)
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



%Mapas de teste:
% OK [[1,1],[1,1],[2,3],[2,2],[2,1],[3,3],[2,2],[3,1],[2,1],[1,1],[3,1],[4,4],[3,2],[2,3],[4,1],[3,2],[2,9],[1,1],[2,1],[2,9],[3,25],[4,10],[2,2],[1,1]] 
% OK [[1,4],[1,3],[2,3],[2,2],[2,1],[3,3],[2,2],[3,1],[2,1],[1,1],[3,1],[4,4],[3,2],[2,3],[4,1],[3,2],[2,9],[1,18],[2,1],[2,9],[3,25],[4,10],[2,2],[1,1]]

main :-
    botJoga([[1,4],[1,3],[2,3],[2,2],[2,1],[3,3],[2,2],[3,1],[2,1],[1,1],[3,1],[4,4],[3,2],[2,3],[4,1],[3,2],[2,9],[1,18],[2,1],[2,9],[3,25],[4,10],[2,2],[1,1]], 1, 1, 1, NovoMapa),
    writeln(NovoMapa).

