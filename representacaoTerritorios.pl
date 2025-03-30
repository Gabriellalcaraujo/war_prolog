:- module(representacaoTerritorios, [imprime_mapa_colorido/1]).

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
    write("⢀⣤⣾⣶⣦⣤⣤⣶⣿⣿⣿⣿⣿⣿⣽⡿⠻⣷⣀⠀⢻⣿⣿⣿⡿⠟⠀ * ⠀⠀⣤⣶⣶⣤⣀⣀⣬⣷⣦⣿⣿⣿⣿⣿⣿⣿").

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
    write("⣿⣿⣿⣿"),

    nth0(17, Mapa, [J8, E8]),
    imprime_siglas_colorido(E8, 18),
    write("⣿⣿⣿⡿⠏⠙⠁"),
    write(" ⠸"),

    nth0(0, Mapa, [J9, E9]),
    imprime_numero_colorido(J9, E9),
    write("⠈⠙⣿⣿⣿"),

    nth0(1, Mapa, [J10, E10]),
    imprime_numero_colorido(J10, E10),
    write("⣿⣷⣦⡄⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀"),

    nth0(7, Mapa, [J11, E11]),
    imprime_siglas_colorido(E11, 8),
    write("⣆⢘"),

    nth0(8, Mapa, [J12, E12]),
    imprime_siglas_colorido(E12, 9),
    write("⣼⣿⣿⣿⣿"), 

    nth0(9, Mapa, [J13, E13]),
    imprime_numero_colorido(J13, E13),
    write("⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"),

    nth0(17, Mapa, [J14, E14]),
    imprime_numero_colorido(J14, E14),
    write("⡿⠀⠀⠀⠀⠀"),
    write("⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"),

    nth0(3, Mapa, [J15, E15]),
    imprime_siglas_colorido(E15, 4),
    write("⠦⠀⠀⠀⠀⠀"), 

    nth0(7, Mapa, [J16, E16]),
    imprime_numero_colorido(J16, E16),
    write("⣿⣿"),

    nth0(8, Mapa, [J17, E17]),
    imprime_numero_colorido(J17, E17),
    write("⣿⣿⣿⣿⣿⣿⣿⣿⣿"),

    nth0(15, Mapa, [J18, E18]),
    imprime_siglas_colorido(E18, 16),
    write("⣿⣿⣿⣿⣿⡿⡗⠀⠈*     "),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿"), nl,

    nth0(4, Mapa, [J19, E19]),
    imprime_siglas_colorido(E19, 5),
    write("⣿⣿⣿⣿⣿"),

    nth0(3, Mapa, [J20, E20]),
    imprime_numero_colorido(J20, E20),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣉⣿⡿⢿⢷⣾"),

    nth0(10, Mapa, [J21, E21]),
    imprime_siglas_colorido(E21, 11),
    write("⣞⣿⣿"),

    nth0(15, Mapa, [J22, E22]),
    imprime_numero_colorido(J22, E22),
    write("⣿⣿"),

    nth0(18, Mapa, [J23, E23]),
    imprime_siglas_colorido(E23, 19),
    write("⣿⣿⣿⠋⣠⠟"),

    nth0(19, Mapa, [J24, E24]),
    imprime_siglas_colorido(E24, 20),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿"),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿"),

    nth0(4, Mapa, [J25, E25]),
    imprime_numero_colorido(J25, E25),
    write("⠿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣾⣿⣿⣷⣦⣶⣦⣼⣿"),

    nth0(10, Mapa, [J26, E26]),
    imprime_numero_colorido(J26, E26),
    write("⣞⣿⣿⣿⣿⣿"),

    nth0(18, Mapa, [J27, E27]),
    imprime_numero_colorido(J27, E27),
    write("⣿⣷⠈⠛⠁"),

    nth0(19, Mapa, [J28, E28]),
    imprime_numero_colorido(J28, E28),
    write("     "), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣤⡖⠛⠶⠤⡀⠀⠀⠀⠀⠀⠀⠀⢰⣿"),

    nth0(11, Mapa, [J29, E29]),
    imprime_siglas_colorido(E29, 12),
    write("⣿⣿⣿"), 

    nth0(12, Mapa, [J30, E30]),
    imprime_siglas_colorido(E30, 13),
    write("⣿⣿⣿⣿⡿⠁⠙⣿⣿⠿⢻⣿⣿⡿⠋⢩⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), 
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠧⣤⣦⣤⣄⡀⠀⠀⠀ * ⠘"),

    nth0(11, Mapa, [J31, E31]),
    imprime_numero_colorido(J31, E31),
    write("⣿⣿⣿"),

    nth0(12, Mapa, [J32, E32]),
    imprime_numero_colorido(J32, E32),
    write("⣿⣿⡇⠀⠀⠀"),

    nth0(20, Mapa, [J33, E33]),
    imprime_siglas_colorido(E33, 21),
    write("⠀⠈⣹"), 

    nth0(21, Mapa, [J34, E34]),
    imprime_siglas_colorido(E34, 22),
    write( "⢀⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿"),

    nth0(5, Mapa, [J35, E35]),
    imprime_siglas_colorido(E35, 6),
    write("⣤⣀⡀*    ⠀⠈⢽⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀"),

    nth0(21, Mapa, [J36, E36]),
    imprime_numero_colorido(J36, E36),
    write("⣿⣷⢲⣦⣤⡀⢀⡀⠀⠀⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿"),

    nth0(5, Mapa, [J37, E37]),
    imprime_numero_colorido(J37, E37),
    write("⣿⠟⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣷"), 

    nth0(14, Mapa, [J38, E38]),
    imprime_siglas_colorido(E38, 15),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠂⠛⣆⣤⡜⣟⠋⠙⠂⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹"),

    nth0(6, Mapa, [J39, E39]),
    imprime_siglas_colorido(E39, 7),
    write("⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀ ⠘⣿"),

    nth0(13, Mapa, [J40, E40]),
    imprime_siglas_colorido(E40, 14),
    write("⣿⠉"),

    nth0(14, Mapa, [J41, E41]),
    imprime_numero_colorido(J41, E41),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿"), 

    nth0(22, Mapa, [J42, E42]),
    imprime_siglas_colorido(E42, 23),
    write("⣿⣆⠀⠰⠄⠀⠉⠀⠀" ), nl,
    write("                 "),

    nth0(6, Mapa, [J43, E43]),
    imprime_numero_colorido(J43, E43),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿"),

    nth0(13, Mapa, [J44, E44]),
    imprime_numero_colorido(J44, E44),
    write("⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿"), 
 
    nth0(22, Mapa, [J45, E45]),
    imprime_numero_colorido(J45, E45),
    write("⣿⣿⠇*"), 

    nth0(23, Mapa, [J46, E46]),
    imprime_siglas_colorido(E46, 24),
    write("   "), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡇⠀"),

    nth0(23, Mapa, [J47, E47]),
    imprime_numero_colorido(J47, E47),
    write("⣼⠗⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠃⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠙⠁⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠒⠀⠀"), nl.


 
    


    








