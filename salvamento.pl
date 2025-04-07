:- module(salvamento,[salvarJogo/2, carregarJogo/7]).

salvarJogo(EstadoDoJogo, NomeArquivo) :-
    open(NomeArquivo, append, Stream),  
    write(Stream, EstadoDoJogo),  
    write(Stream, '.'),
    close(Stream).            

% Observar que essa função assume que o arquivo contem exatamente o estado do jogo
carregarJogo(NomeArquivo, MapaS, JogadoresInfoS, QtdBotsS, ObjetivosS, NumRodadaS, IndiceJogadorS) :-
    open(NomeArquivo, read, Stream),
    read(Stream, EstadoDoJogo),               
    close(Stream),
    nth1(1,EstadoDoJogo,MapaS),
    nth1(2,EstadoDoJogo, JogadoresInfoS),
    nth1(3,EstadoDoJogo, QtdBotsS),  
    nth1(4,EstadoDoJogo,ObjetivosS),                  
    nth1(5,EstadoDoJogo, NumRodadaS),
    nth1(6,EstadoDoJogo, IndiceJogadorS).

