:- use_module(distribuicaoTerritorios).
:- use_module(utilsAtaque).
:- use_module(verificaObjetivosRec).
:- use_module(representacaoTerritorios).
:- use_module(menu).
:- use_module(mapeiaTerritorios).

ataque(Mapa, Terr, Alvo, DadosAtac, DadosDef, NovoMapa):-
    
    calculaPerdas(DadosAtac, DadosDef, PerdasAtaq, PerdasDef),
    batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo, NovoMapa).

batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo, NovoMapa):-
    jogQtdExercitos(Mapa, Terr, QtdAtaq, JogadorAtaq),
    jogQtdExercitos(Mapa, Alvo, QtdDef, JogadorDef),
    NovaQtdAtac is QtdAtaq-PerdasAtaq,
    NovaQtdDef is QtdPerdas-PerdasDef,
    substituirSublista(Mapa, Terr, [JogadorAtaq, NovaQtdAtac], MapaParcial),
    substituirSublista(MapaParcial, Alvo, [JogadorDef, NovaQtdDef], MapaAtualizado),
    NovoMapa = MapaAtualizado.

conquistouTerr(Mapa, Alvo):-
    jogQtdExercitos(Mapa, Alvo, QtdExercitos, _),
    QtdExercitos =:= 0.

inputAtaque(Mapa, IndiceJogador, JogadoresInfo, Objetivos):-
    verificaObjetivosRec(Mapa, JogadoresInfo, Objetivos),
    imprime_mapa_colorido(Mapa),
    repeat,
        writeln("Você deseja atacar? (1)Sim (0)Não"),
        read_line_to_string(user_input, Entrada),
        (atom_number(Entrada, N), verificaOpcao(X) -> !; 
        writeln("Entrada inválida :("), fail),
    (N =:= 1 -> 
        repeat,
        writeln("Qual territorio voce deseja usar para atacar?"),
        read_line_to_string(user_input, Terr), 
        (pertenceMapa(Terr)-> !; writeln("Entrada inválida :("), fail),
        retornaIndice(Terr),
        maxUtilExercitos(Mapa, Terr, Max),
        
        repeat,
        writeln("Qual territorio voce deseja invadir?"),
        read_line_to_string(user_input, Alvo), 
        (pertenceMapa(Alvo), verificaAdjacencia(Terr, Alvo) -> !; 
        writeln("Entrada inválida :("), fail),
        retornaIndice(Alvo),
        
        repeat,
        writeln("Com quantos exercitos voce deseja atacar? min:1, max: ~w", [Max]),
        read_line_to_string(user_input, Qtd),
        (atom_number(Qtd, QtdEx), QtdEx =< Max, QtdEx >= 1 -> !; 
        writeln("Entrada inválida :("), fail),
        jogQtdExercitos(Mapa, Alvo, QtdDef, _),
        min(QtdDef, R), QtdDados is QtdEx + R,
        embaralhar_dados(QtdEx, QtdDados, DadosAtac, DadosDef),
        writeln("DADOS DE ATAQUE: ~w", [DadosAtac]),
        writeln("DADOS DE DEFESA: ~w", [DadosDef]),
        dadosAtaque(DadosAtac, DadosDef) % Pensar em chamar calcula perdas dentro de dadosAtaque
    ), 
    

    


