:- set_prolog_flag(encoding, utf8).
:- use_module(menu).
:- use_module(distribuicaoTerritorios).
:- use_module(mostrarObjetivos).
:- use_module(representacaoTerritorios).
:- use_module(rodada).
:- use_module(ataque).
:- use_module(movimento).
:- use_module(salvamento).


war:-
    repeat,
    writeln("Voce deseja comecar um novo jogo (0) ou continuar um jogo salvo (1)?"),
    read_line_to_string(user_input, D),
    
    ( atom_number(D, N), member(N, [0,1]) ->
        true 
    ;   
        writeln("Entrada invalida :("),
        fail  
    ),

    % Se N = 1, carregar jogo salvo
    ( N =:= 1 ->
        repeat,
        writeln("Digite o nome do jogo que voce quer carregar:"),
        read_line_to_string(user_input, Jogo),
        ( carregarJogo(Jogo, MapaS, JogadoresInfoS, QtdBotsS, ObjetivosS, NumRodadaS, IndiceJogadorS) ->
            rodada(NumRodadaS, JogadoresInfoS, QtdBotsS, ObjetivosS, IndiceJogadorS, MapaS, 1),
            !  
        ;
            writeln("Entrada invalida :("),
            fail  
        )
    ;
        % Novo jogo
        menu(QtdJogF, QtdBotsF),
        QtdJog is QtdJogF + QtdBotsF,
        posicionamento_inicial(QtdJog, NovoMapa),
        atribuir_objetivos(QtdJog, QtdJogF, Objetivos),
        imprime_mapa_colorido(NovoMapa),
        rodada(1, QtdJog, QtdBotsF, Objetivos, 1, NovoMapa, 0),
        !  
    ).
