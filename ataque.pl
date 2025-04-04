:- module(ataque, [inputAtaque/4]).
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
        read_line_to_string(user_input, Sigla), 
        (pertenceMapa(Sigla)-> !; writeln("Entrada inválida :("), fail),
        retornaIndice(Sigla, Terr),
        maxUtilExercitos(Mapa, Terr, Max),
        
        repeat,
        writeln("Qual territorio voce deseja invadir?"),
        read_line_to_string(user_input, SiglaAlvo), 
        retornaIndice(SiglaAlvo, Alvo), 
        (pertenceMapa(SiglaAlvo), verificaAdjacencia(Terr, Alvo) -> !; 
        writeln("Entrada inválida :("), fail),
        
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
        formataDados(DadosAtac, DadosDef, PerdasAtaq, PerdasDef), % Pensar em chamar calcula perdas dentro de dadosAtaque
        format("O jogador atacante perdeu ~w exercitos", [PerdasAtaq]), nl,
        format("O jogador defensor perdeu ~w exercitos", [PerdasDef]), nl,
        batalhaMapa(Mapa, PerdasAtaq, PerdasDef, Terr, Alvo, NovoMapa),
        maxUtilExercitos(NovoMapa, Terr, NovoMax),

        repeat,
        format("Com quantos exercitos voce deseja atacar? min:1, max: ~w", [Max]), nl,
        read_line_to_string(user_input, Qtd),
        (atom_number(Qtd, QtdEx), QtdEx =< Max, QtdEx >= 1 -> !; 
        writeln("Entrada inválida :("), fail),
        
        nth1(Alvo, NovoMapa, Sublista),
        novaQtdExercitos(Sublista, QtdT, Resultado),
        substituirSublista(NovoMapa, Alvo, [IndiceJogador, Resultado], MapaAtt),
        jogQtdExercitos(MapaAtt, Terr, QtdExercitos, _),
        NovaQtdE is QtdExercitos - QtdT,
        substituirSublista(MapaAtt, Terr, [IndiceJogador, NovaQtdE], MapaAtt2)),
        inputAtaque(MapaAtt2, IndiceJogador, JogadoresInfo, Objetivos);
        true.
    



