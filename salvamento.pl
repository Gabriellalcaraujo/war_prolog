salvarJogo(EstadoDoJogo, NomeArquivo) :-
    open(NomeArquivo, append, Stream),  
    write(Stream, EstadoDoJogo),  
    write(Stream, '.'),
    close(Stream).            

% Observar que essa função assume que o arquivo contem exatamente o estado do jogo
carregarJogo(NomeArquivo, EstadoDoJogo) :-
    open(NomeArquivo, read, Stream),
    read(Stream, EstadoDoJogo),               
    close(Stream).                     
       

% testando com um mapa aleatório
main:- carregarJogo('teste.txt', EstadoDoJogo),write(EstadoDoJogo).