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
    repeat,
        writeln("Você deseja mover algum exército? (1)Sim (0)Não"),
        read_line_to_string(user_input, Entrada),
        (atom_number(Entrada, N),
          member(N, [0, 1]) -> ! ; 
          writeln("Entrada inválida :("), fail),
    (N =:= 1 ->
        repeat,
            writeln("De qual território você deseja transferir os exércitos?"),
            read_line_to_string(user_input, Sigla),
            (pertenceMapa(Sigla), retornaIndice(Sigla, Terr), \+ movimentoJaRealizado(Terr, MovimentosFeitos) -> ! ; 
            writeln("Entrada inválida :("), fail),

        repeat,
            writeln("E para qual território deseja transferir?"),
            read_line_to_string(user_input, SiglaAlvo),
            retornaIndice(SiglaAlvo, Alvo),
            (pertenceMapa(SiglaAlvo),
            verificaAdjacencia(Terr, Alvo) -> ! ; 
            writeln("Entrada inválida :("), fail),
            Movimentados is append(MovimentosFeitos, [Alvo]),

        repeat,
            maxUtilExercitos(Mapa, Terr, Max),
            format("Quantos exércitos serão transferidos? (min: 1, max: ~w)~n", [Max]),
            read_line_to_string(user_input, Qtd),
            (atom_number(Qtd, QtdEx),
            QtdEx =< Max,
            QtdEx >= 1 -> ! ;
            writeln("Entrada inválida :("), fail),

        jogQtdExercitos(Mapa, Terr, QtdOrigem, Jogador),
        jogQtdExercitos(Mapa, Alvo, QtdDestino, Jogador),

        NovaQtdOrigem is QtdOrigem - QtdEx,
        NovaQtdDestino is QtdDestino + QtdEx,

        substituirSublista(Mapa, Terr, [Jogador, NovaQtdOrigem], MapaParcial),
        substituirSublista(MapaParcial, Alvo, [Jogador, NovaQtdDestino], NovoMapa),
        inputMovimento(NovoMapa, Jogador, JogadoresInfo, MovimentosFeitos, Objetivos, MapaF);
        MapaF = Mapa, true).
