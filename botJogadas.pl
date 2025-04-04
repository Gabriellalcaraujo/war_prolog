:- use_module(mapeiaTerritorios).

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
            botAtaque(Mapa, IndiceJogador, Ataque, Objetivos, MapaAposAtaque), %FALTA DEFINIR COM QUANTOS EXÉRCITOS ELE VAI ATACAR
            possibilidadesDeAtaque(MapaAposAtaque, IndiceJogador, NovasPossibilidades),
            ( NovasPossibilidades == [] -> 
                format("O jogador ~w não tem mais ataques disponíveis e passou a vez.~n", [IndiceJogador]), 
                NovoMapa = MapaAposAtaque
            ;   
                botJoga(MapaAposAtaque, JogInfo, IndiceJogador, Objetivos, NovoMapa)
            )
        )
    ).

botAtaque(Mapa, IndiceJogador, Ataque, Objetivos, MapaAposAtaque) :- MapaAposAtaque = Mapa.


 %APARENTEMENTE FUNCIONANDO
 %retorna uma lista de pares, que são os possíveis ataques do bot
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

