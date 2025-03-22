retornaIndice(Sigla, Indice):-
    Territorios =  ['AL', 'CA', 'GL', 'NY', 'MX', 'BR', 'AR', 'UK', 'GE', 'SP', 
              'TU', 'MR', 'EG', 'SA', 'MA', 'MO', 'SI', 'VL', 'CH', 'JP', 
              'IN', 'VI', 'AU', 'NZ'],
    nth1(Indice, Territorios, Sigla).

retornaSigla(Indice, Sigla):-
    Territorios =  ['AL', 'CA', 'GL', 'NY', 'MX', 'BR', 'AR', 'UK', 'GE', 'SP', 
              'TU', 'MR', 'EG', 'SA', 'MA', 'MO', 'SI', 'VL', 'CH', 'JP', 
              'IN', 'VI', 'AU', 'NZ'],
    nth1(Indice, Territorios, Sigla).

verificaAdjacencia(Indice1, Indice2):-
    MatrizAdjacencia =
    [
        [2, 18], [1, 5, 4, 3], [8, 2, 4], [3, 2, 5], 
        [4, 2, 6], [5, 7, 12], [6], [3, 9], 
        [8, 12, 10], [9, 11, 16, 17], [13, 10, 16], 
        [6, 9, 13], [15, 14], [15, 13], [14, 13], 
        [11, 10, 17, 19, 21], [16, 18, 10, 19],
        [1, 17, 20], [21, 22, 20, 16, 17], [18, 19], [16, 19, 22], 
        [23, 21, 19], [24, 22], [23]
    ], nth1(Indice1, MatrizAdjacencia, Lista), member(Indice2, Lista).