:- module(salvamento, [salvarJogo/2, carregarJogo/2]).

salvarJogo(EstadoDoJogo, NomeArquivo) :-
    open(NomeArquivo, append, Stream),  
    write(Stream, EstadoDoJogo),  
    write(Stream, '.'),
    close(Stream).            

% Observar que essa função assume que o arquivo contem exatamente o estado do jogo
carregarJogo(NomeArquivo, Mapa, JogadoresInfo, QtdBots, Objetivos, NumRodada, IndiceJogador) :-
    open(NomeArquivo, read, Stream),
    read(Stream, EstadoDoJogo),               
    close(Stream),
    nth1(1,EstadoDoJogo,Mapa),
    nth1(2,EstadoDoJogo, JogadoresInfo),
    nth1(3,EstadoDoJogo, QtdBots),  
    nth1(4,EstadoDoJogo,Objetivos),                  
    nth1(5,EstadoDoJogo, NumRodada),
    nth1(6,EstadoDoJogo, IndiceJogador).

% testando com um mapa aleatório
main:- carregarJogo('teste.txt',Mapa, JogadoresInfo, QtdBots, Objetivos, NumRodada, IndiceJogador),write(Mapa).