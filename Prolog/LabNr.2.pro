implement main
    open core, file, stdio

domains
    typeofmovies = action; comedy; drama; thriller; romance; horror; western; crime.

class facts - fileAna
    cinema : (integer Num, string Cin, string Addr, string Phone, integer Seat).
    movie : (integer Num_1, string Title, integer Year, string Dir, typeofmovies Gen).
    show : (integer Num_cin, integer Id_movie, string Date, string Time, integer Reve).

% Правило: Адрес кинотеатра, показывающий фильм определенного жанра
class predicates
    address_of_cinema_genre : (string Addr [out], typeofmovies Gen [out]) nondeterm.
clauses
    address_of_cinema_genre(Addr, Gen) :-
        show(Num, Num_1, _, _, _),
        movie(Num_1, _, _, _, Gen),
        cinema(Num, _, Addr, _, _).

%Правило: Кинотеатр, показывающий определенный фильм.
class predicates
    cinema_show_genre : (string Cin [out], string Title [out]) nondeterm.
clauses
    cinema_show_genre(Cin, Title) :-
        cinema(Num, Cin, _, _, _),
        show(Num, Id_movie, _, _, _),
        movie(Id_movie, Title, _, _, _).

class predicates
    printShows : ().
    increaseShow : (integer R).

clauses
    printShows() :-
        show(Num_cin, _, _, _, Reve),
        write(Num_cin, ":\t", Reve),
        nl,
        fail.
    printShows() :-
        write("All the revenue above\n").

class facts
    stats : (integer Min, integer Count, integer Sum) single.

clauses
    stats(0, 0, 0).

class predicates
    countNumberStats : ().
    min : (integer X, integer Y, integer Z [out]).

clauses
    min(X, Y, X) :-
        X <= Y,
        !.
    min(_, Y, Y).

clauses
    countNumberStats() :-
        assert(stats(635536, 0, 0)),
        show(_, _, _, _, Reve),
        stats(Min, Count, Sum),
        min(Min, Reve, Mininew),
        assert(stats(Mininew, Count + 1, Sum + Reve)),
        fail.
    countNumberStats() :-
        stats(Count, Min, Sum),
        writef("Count of the cinemas: %\n Smallest number revenue: %\nTotal revenue: %\n", Min, Count, Sum).

clauses
    increaseShow(R) :-
        retract(show(Num_cin, Id_movie, Date, Time, Reve)),
        asserta(show(Num_cin, Id_movie, Date, Time, Reve + R)),
        fail.
    increaseShow(_).

class predicates
    reconsult : (string File).
clauses
    reconsult(File) :-
        retractFactDB(fileAna),
        consult(File, fileAna).

clauses
    run() :-
        console::init(),
        reconsult("..\\fileAna.txt"),
        address_of_cinema_genre(Addr, Gen),
        write(Addr, " - ", Gen, "\n"),
        fail.
    run() :-
        write(" \n"),
        cinema_show_genre(Cin, Title),
        write(Cin, " - ", Title, "\n"),
        fail.
    run() :-
        printShows(),
        countNumberStats(),
        X = stdio::readLine(),
        increaseShow(toTerm(X)),
        printShows(),
        countNumberStats().

end implement main

goal
    console::runUtf8(main::run).
