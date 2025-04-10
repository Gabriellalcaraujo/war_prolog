:- module(ataque, [inputAtaque/5, batalhaMapa/6, conquistouTerr/2]).
:- use_module(distribuicaoTerritorios).
:- use_module(utilsAtaque).
:- use_module(verificaObjetivos).
:- use_module(representacaoTerritorios).
:- use_module(menu).
:- use_module(mapeiaTerritorios).


batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo, NovoMapa):-
    jogQtdExercitos(Mapa, Terr, QtdAtaq, JogadorAtaq),
    jogQtdExercitos(Mapa, Alvo, QtdDef, JogadorDef),
    NovaQtdAtac is QtdAtaq-PerdasAtaq,
    NovaQtdDef is QtdDef-PerdasDef,
    substituirSublista(Mapa, Terr, [JogadorAtaq, NovaQtdAtac], MapaParcial),
    substituirSublista(MapaParcial, Alvo, [JogadorDef, NovaQtdDef], NovoMapa).

conquistouTerr(Mapa, Alvo):-
    jogQtdExercitos(Mapa, Alvo, QtdExercitos, _),
    QtdExercitos =:= 0. 

inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF):-
    verificaObjetivosRec(Mapa, JogadoresInfo, Objetivos),
    imprime_mapa_colorido(Mapa),

    writeln("Você deseja atacar? (1)Sim (0)Não"),
    read_line_to_string(user_input, Entrada),
    (
        atom_number(Entrada, N),
        member(N, [0, 1])
    ->
        (
            N =:= 0 ->
                MapaF = Mapa  % jogador não quer atacar, finaliza turno
            ;
                % jogador deseja atacar
                writeln("Qual território você deseja usar para atacar?"),
                read_line_to_string(user_input, Sigla),
                (
                    pertenceMapa(Sigla),
                    retornaIndice(Sigla, Terr),
                    jogQtdExercitos(Mapa, Terr, QtdE, _), QtdE > 1,
                    ehDoJogador(Mapa, Terr, IndiceJogador)
                ->
                    maxUtilExercitos(Mapa, Terr, Max),
                    writeln("Qual território você deseja invadir?"),
                    read_line_to_string(user_input, SiglaAlvo),
                    (
                        pertenceMapa(SiglaAlvo),
                        retornaIndice(SiglaAlvo, Alvo),
                        verificaAdjacencia(Terr, Alvo),
                        \+ ehDoJogador(Mapa, Alvo, IndiceJogador)
                    ->
                        format("Com quantos exércitos você deseja atacar? min:1, max: ~w~n", [Max]),
                        read_line_to_string(user_input, QtdStr),
                        (
                            atom_number(QtdStr, QtdEx),
                            QtdEx =< Max,
                            QtdEx >= 1
                        ->
                            jogQtdExercitos(Mapa, Alvo, QtdDef, _),
                            min(QtdDef, R),
                            QtdDados is QtdEx + R,
                            embaralhar_dados(QtdEx, QtdDados, DadosAtac, DadosDef),
                            format("DADOS DE ATAQUE: ~w~n", [DadosAtac]),
                            format("DADOS DE DEFESA: ~w~n", [DadosDef]),
                            formataDados(DadosAtac, DadosDef, PerdasAtaq, PerdasDef),
                            format("O jogador atacante perdeu ~w exércitos~n", [PerdasAtaq]),
                            format("O jogador defensor perdeu ~w exércitos~n", [PerdasDef]),
                            batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo, NovoMapa),
                            maxUtilExercitos(NovoMapa, Terr, NovoMax),
                            (
                                conquistouTerr(NovoMapa, Alvo)
                            ->
                                format("Você conquistou o território! Quantos exércitos você deseja transferir? min: 1, max: ~w~n", [NovoMax]),
                                read_line_to_string(user_input, QtdTransfStr),
                                (
                                    atom_number(QtdTransfStr, QtdTransf),
                                    QtdTransf =< NovoMax,
                                    QtdTransf >= 1
                                ->
                                    substituirSublista(NovoMapa, Alvo, [IndiceJogador, QtdTransf], MapaAtt),
                                    jogQtdExercitos(MapaAtt, Terr, QtdExercitos, _),
                                    NovaQtdE is QtdExercitos - QtdTransf,
                                    substituirSublista(MapaAtt, Terr, [IndiceJogador, NovaQtdE], MapaAtt2),
                                    inputAtaque(MapaAtt2, IndiceJogador, JogadoresInfo, Objetivos, MapaF)
                                ;
                                    writeln("Entrada inválida :("),
                                    inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)
                                )
                            ;
                                inputAtaque(NovoMapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)
                            )
                        ;
                            writeln("Entrada inválida :("),
                            inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)
                        )
                    ;
                        writeln("Entrada inválida :("),
                        inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)
                    )
                ;
                    writeln("Entrada inválida :("),
                    inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)
                )
        )
    ;
        writeln("Entrada inválida :("),
        inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)
    ).

    



