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

    nth0(2, Mapa, [J1, E1]), % gl
    imprime_siglas_colorido(J1, 3),
    write("⣿⣿⡿⠋⠀⠀⠀⢠⣤⣦⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("*⠀⠀⠀⠀⠀⠀⠀⣼⣿⣟⣾⣿⣽⣿⣿⣅⠈⠉⠻⣿"),

    imprime_numero_colorido(J1, E1),
    write("⣿⡿⠇*⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⢀⡶⠒⢉⡀⢠⣤⣶⣶⣿⣷⣆⣀⡀⠀⢲⣖⠒⠀⠀⠀⠀⠀⠀*"), nl,
    write("⢀⣤⣾⣶⣦⣤⣤⣶⣿⣿⣿⣿⣿⣿⣽⡿⠻⣷⣀⠀⢻⣿⣿⣿⡿⠟⠀ * ⠀⠀⣤⣶⣶⣤⣀⣀⣬⣷⣦⣿⣿⣿⣿⣿⣿⣿"),

    nth0(16, Mapa, [J3, E3]), % si 
    imprime_siglas_colorido(J3, 17),
    write("⣿⣿⣿⣿⣿⣿⣶⣦⣤⣦⣼⣀⠀"), nl,
    write("⠈⣿"),

    nth0(0, Mapa, [J4, E4]), % al
    imprime_siglas_colorido(J4, 1),
    write("⣿⣿⣿⣿⣿⣿"),

    nth0(1, Mapa, [J5, E5]), % na / ca 
    imprime_siglas_colorido(J5, 2),
    write("⣿⣿⡿⠛⠓⣿⣿⠟⠁⠘⣿⡟⠁⠀⠘⠛⠁⠀*⢠⣾⣿⢿⣿⣿⣿⣿"),

    nth0(9, Mapa, [J6, E6]), % sp 
    imprime_siglas_colorido(J6, 10),
    write("⣿⣿⣿⣿⣿⣿⣿"), nl,

   % numero de si 
    imprime_numero_colorido(J3, E3),
    write("⣿⣿⣿⣿"),

    nth0(17, Mapa, [J8, E8]), % vl 
    imprime_siglas_colorido(J8, 18),
    write("⣿⣿⣿⡿⠏⠙⠁"), nl, 
    write(" ⠸"),

    % numero de al 
    imprime_numero_colorido(J4, E4),
    write("⠈⠙⣿⣿⣿"),


    % numero de na 
    imprime_numero_colorido(J5, E5),
    write("⣿⣷⣦⡄⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀"),

    nth0(7, Mapa, [J11, E11]), % uk 
    imprime_siglas_colorido(J11, 8),
    write("⣆⢘"),

    nth0(8, Mapa, [J12, E12]), % ge 
    imprime_siglas_colorido(J12, 9),
    write("⣼⣿⣿⣿⣿"), 

    % numero de sp
    imprime_numero_colorido(J6, E6),
    write("⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"),

    % numero de vl 
    imprime_numero_colorido(J8, E8), 
    write("⡿⠀⠀⠀⠀⠀"), nl, 
    write("⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"),

    nth0(3, Mapa, [J15, E15]), % ny 
    imprime_siglas_colorido(J15, 4),
    write("⠦⠀⠀⠀⠀⠀"), 

    % numero uk 
    imprime_numero_colorido(J11, E11),
    write("⣿⣿"),

    % numero de ge 
    imprime_numero_colorido(J12, E12),
    write("⣿⣿⣿⣿⣿⣿⣿⣿⣿"),

    nth0(15, Mapa, [J18, E18]), % mo 
    imprime_siglas_colorido(J18, 16),
    write("⣿⣿⣿⣿⣿⡿⡗⠀⠈*     "), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿"), 

    nth0(4, Mapa, [J19, E19]), % mx 
    imprime_siglas_colorido(E19, 5),
    write("⣿⣿⣿⣿⣿"),

    % numero de ny 
    imprime_numero_colorido(J15, E15),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣉⣿⡿⢿⢷⣾"),

    nth0(10, Mapa, [J21, E21]), % tu 
    imprime_siglas_colorido(J21, 11),
    write("⣞⣿⣿"),

    % numero de mo 
    imprime_numero_colorido(J18, E18),
    write("⣿⣿"),

    nth0(18, Mapa, [J23, E23]), % ch 
    imprime_siglas_colorido(J23, 19),
    write("⣿⣿⣿⠋⣠⠟"),

    nth0(19, Mapa, [J24, E24]), % jp 
    imprime_siglas_colorido(J24, 20),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿"),

    % numero de mx 
    imprime_numero_colorido(J19, E19),
    write("⠿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣾⣿⣿⣷⣦⣶⣦⣼⣿"),

    nth0(11, Mapa, [J26, E26]), % mr 
    imprime_numero_colorido(J26, E26),
    write("⣷⣦⣶⣦⣼⣿"),

    % numero tu 
    imprime_numero_colorido(J21, E21),
    write("⣿⣿⣿⣿⣿⣿⣿"),

    % numero ch
    imprime_numero_colorido(J23, E23),
    write("⣿⣷⠈⠛⠁"), 

    % numero jp 
    imprime_numero_colorido(J24, E24),
    write("       "), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣤⡖⠛⠶⠤⡀⠀⠀⠀⠀⠀⠀⠀⢰⣿"),

    % numero de mr 
    imprime_numero_colorido(J26, E26),
    write("⣿⣿"),

    nth0(12, Mapa, [J30, E30]), % eg 
    imprime_siglas_colorido(J30, 13),
    write("⣿⣿⣿⣿⡿⠁⠙⣿⣿⠿⢻⣿⣿⡿⠋⢩⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠧⣤⣦⣤⣄⡀⠀⠀⠀ * ⠘⣿⣿⣿⣿⣿"),

    % numero eg 
    imprime_numero_colorido(J30, E30),
    write("⣿⣿⡇⠀⠀⠀"),

    nth0(20, Mapa, [J33, E33]), % in 
    imprime_siglas_colorido(J33, 21),
    write("⠀⠈⣹"), 

    nth0(21, Mapa, [J34, E34]), % vi 
    imprime_siglas_colorido(J34, 22),
    write( "⢀⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿"),

    nth0(5, Mapa, [J35, E35]), % br
    imprime_siglas_colorido(J35, 6),
    write("⣤⣀⡀*    ⠀⠈⢽⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀"),

    % numero in 
    imprime_numero_colorido(J33, E33),
    write(" "),

    % numero vi
    imprime_numero_colorido(J34, E34),
    write("⢀⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿"),

    % numero br 
    imprime_numero_colorido(J35, E35),
    write("⣿⠟⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣷"),

    nth0(14, Mapa, [J38, E38]), % ma 
    imprime_siglas_colorido(J38, 15),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠂⠛⣆⣤⡜⣟⠋⠙⠂⠀⠀⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹"),
    
    nth0(6, Mapa, [J39, E39]), % ar
    imprime_siglas_colorido(J39, 7), 
    write("⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀ ⠘⣿"),

    nth0(13, Mapa, [J40, E40]), % sa 
    imprime_siglas_colorido(J40, 14), 
    write("⣿⠉"),

    % numero de ma 
    imprime_numero_colorido(J38, E38),
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿"),

    nth0(22, Mapa, [J42, E42]), % au 
    imprime_siglas_colorido(J42, 23),
    write("⣿⣆⠀⠰⠄⠀⠉⠀⠀" ), nl,
    write("                 "),

    % numero de ar 
    imprime_numero_colorido(J39, E39),
    write("⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀   "),

    % numero de sa 
    imprime_numero_colorido(J40, E40),
    write("⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿"), 

    % numero de au 
    imprime_numero_colorido(J42, E42),
    write("⣿⣿⠇*"),

    nth0(23, Mapa, [J46, E46]), % nz
    imprime_siglas_colorido(J46, 24),
    write("   "), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡇⠀"),

    % numero de nz 
    imprime_numero_colorido(J46, E46),
    write("⣼⠗⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠃⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠙⠁⠀⠀"), nl,
    write("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠒⠀⠀"), nl.



 
    


    








