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

imprime_siglas_colorido(Indice, Territorio) :-
    define_cor(Indice),
    retornaSigla(Territorio, Sigla),
    write(Sigla),
    reset_color. 

imprime_numero_colorido(Indice, Numero) :-
    define_cor(Indice),
    % format_number(Numero, NumeroFormatado),
    % write(NumeroFormatado),
    write(Numero),
    reset_color.

imprime_mapa_formatado(Mapa) :-
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣄⣠⣀⡀⣀⣠⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⢠⣠⣼⣿⣿⣿⣟⣿⣿⣿⣿"),
    nth0(2, Mapa, [J1, T1]),
    imprime_siglas_colorido(J1, T1),
    write("⣿⣿⡿⠋⠀⠀⠀⢠⣤⣦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("*⠀⠀⠀⠀⠀⠀⠀⣼⣿⣟⣾⣿⣽⣿⣿⣅⠈⠉⠻⣿"),
    nth0(2, Mapa, [J2, N2]),
    imprime_numero_colorido(J2, N2),
    write("⣿⡿⠇*⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⢀⡶⠒⢉⡀⢠⣤⣶⣶⣿⣷⣆⣀⡀⠀⢲⣖⠒⠀⠀⠀⠀⠀⠀*"), nl,
    write("⢀⣤⣾⣶⣦⣤⣤⣶⣿⣿⣿⣿⣿⣿⣽⡿⠻⣷⣀⠀⢻⣿⣿⣿⡿⠟⠀ * ⠀⠀⣤⣶⣶⣤⣀⣀⣬⣷⣦⣿⣿⣿⣿⣿⣿⣿"),
    nth0(16, Mapa, [J3, T3]),
    imprime_siglas_colorido(J3, T3),
    write("⣿⣿⣿⣿⣿⣿⣶⣦⣤⣦⣼⣀⠀"), nl,
    write("⠈⣿").
