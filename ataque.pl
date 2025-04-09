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
    writeln(QtdAtaq),
    writeln(QtdDef),
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
    repeat,
        writeln("Você deseja atacar? (1)Sim (0)Não"),
        read_line_to_string(user_input, Entrada),
        (atom_number(Entrada, N), verificaOpcao(N) -> true; 
        writeln("Entrada inválida :("), fail), !, 
    (N =:= 0 -> MapaF = Mapa, !;
        writeln("Qual territorio voce deseja usar para atacar?"),
        read_line_to_string(user_input, Sigla), 
        (pertenceMapa(Sigla), 
        retornaIndice(Sigla, Terr), 
        jogQtdExercitos(Mapa, Terr, QtdE, _), QtdE > 1,
        ehDoJogador(Mapa, Terr, IndiceJogador) -> !; 
        writeln("Entrada inválida :("), inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)),
        maxUtilExercitos(Mapa, Terr, Max),
        
        writeln("Qual territorio voce deseja invadir?"),
        read_line_to_string(user_input, SiglaAlvo),  
        (pertenceMapa(SiglaAlvo), retornaIndice(SiglaAlvo, Alvo), 
        verificaAdjacencia(Terr, Alvo), \+ ehDoJogador(Mapa, Alvo, IndiceJogador) -> !; 
        writeln("Entrada inválida :("), inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF)),
        
        repeat,
        format("Com quantos exercitos voce deseja atacar? min:1, max: ~w", [Max]), nl,
        read_line_to_string(user_input, Qtd),
        (atom_number(Qtd, QtdEx), QtdEx =< Max, QtdEx >= 1 -> !; 
        writeln("Entrada inválida :("), fail),

        jogQtdExercitos(Mapa, Alvo, QtdDef, _),
        min(QtdDef, R), QtdDados is QtdEx + R,
        embaralhar_dados(QtdEx, QtdDados, DadosAtac, DadosDef),
        format("DADOS DE ATAQUE: ~w", [DadosAtac]), nl,
        format("DADOS DE DEFESA: ~w", [DadosDef]), nl, nl,
        formataDados(DadosAtac, DadosDef, PerdasAtaq, PerdasDef),
        
        format("O jogador atacante perdeu ~w exercitos", [PerdasAtaq]), nl,
        format("O jogador defensor perdeu ~w exercitos", [PerdasDef]), nl,
        batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo, NovoMapa),
        maxUtilExercitos(NovoMapa, Terr, NovoMax),
    
        (conquistouTerr(NovoMapa, Alvo)->
        repeat,
        format("Você conquistou o território! Quantos exércitos você deseja transferir? min: 1, max: ~w~n", [NovoMax]),
        read_line_to_string(user_input, QtdN),
        (atom_number(QtdN, QtdTransf), QtdTransf =< NovoMax, QtdTransf >= 1 -> !; 
        writeln("Entrada inválida :("), fail),
        
        substituirSublista(NovoMapa, Alvo, [IndiceJogador, QtdTransf], MapaAtt),
        jogQtdExercitos(MapaAtt, Terr, QtdExercitos, _),
        NovaQtdE is QtdExercitos - QtdTransf,
        substituirSublista(MapaAtt, Terr, [IndiceJogador, NovaQtdE], MapaAtt2),
        inputAtaque(MapaAtt2, IndiceJogador, JogadoresInfo, Objetivos,  MapaF);
        inputAtaque(NovoMapa, IndiceJogador, JogadoresInfo, Objetivos, MapaF))).
    



