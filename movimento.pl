:- module(movimento, [inputMovimento/6]).
:- use_module(distribuicaoTerritorios).
:- use_module(representacaoTerritorios).
:- use_module(verificaObjetivos).
:- use_module(mapeiaTerritorios).
:- use_module(utilsAtaque).

movimentoJaRealizado(Terr, Movimentos):-
    member(Terr, Movimentos).

inputMovimento(Mapa, Jogador, JogadoresInfo, MovimentosFeitos, Objetivos, MapaF) :-
    verificaObjetivosRec(Mapa, JogadoresInfo, Objetivos),
    imprime_mapa_colorido(Mapa),

    writeln("Você deseja mover algum exército? (1)Sim (0)Não"),
    read_line_to_string(user_input, Entrada),
    (
        atom_number(Entrada, N),
        member(N, [0, 1])
    ->
        (
            N =:= 0 ->
                MapaF = Mapa  % jogador não quer mover exércitos
            ;
                % jogador quer mover
                writeln("De qual território você deseja transferir os exércitos?"),
                read_line_to_string(user_input, Sigla),
                (
                    pertenceMapa(Sigla),
                    retornaIndice(Sigla, Terr),
                    ehDoJogador(Mapa, Terr, Jogador),
                    \+ movimentoJaRealizado(Terr, MovimentosFeitos),
                    jogQtdExercitos(Mapa, Terr, Qtd, _), Qtd > 1
                ->
                    writeln("E para qual território deseja transferir?"),
                    read_line_to_string(user_input, SiglaAlvo),
                    (
                        pertenceMapa(SiglaAlvo),
                        retornaIndice(SiglaAlvo, Alvo),
                        verificaAdjacencia(Terr, Alvo),
                        ehDoJogador(Mapa, Alvo, Jogador),
                        Terr =\= Alvo
                    ->
                        append(MovimentosFeitos, [Alvo], Movimentados),
                        maxUtilExercitos(Mapa, Terr, Max),
                        format("Quantos exércitos serão transferidos? (min: 1, max: ~w)~n", [Max]),
                        read_line_to_string(user_input, QtdN),
                        (
                            atom_number(QtdN, QtdEx),
                            QtdEx =< Max,
                            QtdEx >= 1
                        ->
                            jogQtdExercitos(Mapa, Terr, QtdOrigem, Jogador),
                            jogQtdExercitos(Mapa, Alvo, QtdDestino, Jogador),
                            NovaQtdOrigem is QtdOrigem - QtdEx,
                            NovaQtdDestino is QtdDestino + QtdEx,
                            substituirSublista(Mapa, Terr, [Jogador, NovaQtdOrigem], MapaParcial),
                            substituirSublista(MapaParcial, Alvo, [Jogador, NovaQtdDestino], NovoMapa),
                            inputMovimento(NovoMapa, Jogador, JogadoresInfo, Movimentados, Objetivos, MapaF)
                        ;
                            writeln("Entrada inválida :("),
                            inputMovimento(Mapa, Jogador, JogadoresInfo, MovimentosFeitos, Objetivos, MapaF)
                        )
                    ;
                        writeln("Entrada inválida :("),
                        inputMovimento(Mapa, Jogador, JogadoresInfo, MovimentosFeitos, Objetivos, MapaF)
                    )
                ;
                    writeln("Entrada inválida :("),
                    inputMovimento(Mapa, Jogador, JogadoresInfo, MovimentosFeitos, Objetivos, MapaF)
                )
        )
    ;
        writeln("Entrada inválida :("),
        inputMovimento(Mapa, Jogador, JogadoresInfo, MovimentosFeitos, Objetivos, MapaF)
    ).

