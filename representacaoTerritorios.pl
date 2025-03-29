retornaSigla(Indice, Sigla):-
    Territorios =  ['AL', 'CA', 'GL', 'NY', 'MX', 'BR', 'AR', 'UK', 'GE', 'SP', 
              'TU', 'MR', 'EG', 'SA', 'MA', 'MO', 'SI', 'VL', 'CH', 'JP', 
              'IN', 'VI', 'AU', 'NZ'],
    nth1(Indice, Territorios, Sigla).

define_cor(1) :- write('\033[36m').   % Cyan
define_cor(2) :- write('\033[33m').   % Yellow
define_cor(3) :- write('\033[32m').   % Green
define_cor(_) :- write('\033[35m').   % Magenta 

reset_color :- write('\033[0m').

imprime_siglas_colorido(Jogador, Indice) :-
    define_cor(Jogador),
    retornaSigla(Indice, Sigla), 
    write(Sigla),
    reset_color. 

imprime_numero_colorido(Jogador, Numero) :-
    define_cor(Jogador),
    % format_number(Numero, NumeroFormatado),
    % write(NumeroFormatado),
    write(Numero),
    reset_color.

imprime_mapa_colorido(Mapa) :-
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣄⣠⣀⡀⣀⣠⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⢠⣠⣼⣿⣿⣿⣟⣿⣿⣿⣿"),

    nth0(2, Mapa, [J1, E1]),
    imprime_siglas_colorido(J1, 3),
    write("⣿⣿⡿⠋⠀⠀⠀⢠⣤⣦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("*⠀⠀⠀⠀⠀⠀⠀⣼⣿⣟⣾⣿⣽⣿⣿⣅⠈⠉⠻⣿"),

    imprime_numero_colorido(J1, E1),
    write("⣿⡿⠇*⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⢀⡶⠒⢉⡀⢠⣤⣶⣶⣿⣷⣆⣀⡀⠀⢲⣖⠒⠀⠀⠀⠀⠀⠀*"), nl,
    write("⢀⣤⣾⣶⣦⣤⣤⣶⣿⣿⣿⣿⣿⣿⣽⡿⠻⣷⣀⠀⢻⣿⣿⣿⡿⠟⠀ * ⠀⠀⣤⣶⣶⣤⣀⣀⣬⣷⣦⣿⣿⣿⣿⣿⣿⣿"),
    
    nth0(16, Mapa, [J3, E3]),
    imprime_siglas_colorido(J3, 17),
    write("⣿⣿⣿⣿⣿⣿⣶⣦⣤⣦⣼⣀⠀"), nl,
    write("⠈⣿"),

    nth0(0, Mapa, [J4, E4]),
    imprime_siglas_colorido(J4, 1),
    write("⣿⣿⣿⣿⣿⣿"),

    nth0(1, Mapa, [J5, E5]),
    imprime_siglas_colorido(J5, 2),
    write("⣿⣿⡿⠛⠓⣿⣿⠟⠁⠘⣿⡟⠁⠀⠘⠛⠁⠀*⢠⣾⣿⢿⣿⣿⣿⣿"),

    nth0(9, Mapa, [J6, E6]),
    imprime_siglas_colorido(J6, 10),
    write("⣿⣿⣿⣿⣿⣿⣿"), nl,

    nth0(16, Mapa, [J7, E7]),
    imprime_numero_colorido(E7, 17),
    write("⣿⣿⣿⣿").