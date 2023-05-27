implement main
    open core, stdio

domains
    typeofmovies = action; comedy; drama; thriller; romance; horror; western; crime.

class facts
    cinema : (integer Num, string Cin, string Addr, string Phone, integer Seat).
    movie : (integer Num_1, string Title, integer Year, string Dir, typeofmovies Gen).
    show : (integer Num_cin, integer Id_movie, string Date, string Time, integer Reve).

% Кинотеатр (id, название, адрес, телефон, количество мест)
clauses
    cinema(1, 'Cinema A', '123 Main St', '123-456-7890', 100).
    cinema(2, 'Cinema B', '456 Elm St', '987-654-3210', 150).
    cinema(3, 'Cinema C', '789 Oak St', '555-555-5555', 200).
    cinema(4, 'Cinema D', '789 Maple St', '111-222-3333', 120).
    cinema(5, 'Cinema E', '321 Pine St', '444-555-6666', 180).
    cinema(6, 'Cinema F', '567 Oak St', '777-888-9999', 150).
    cinema(7, 'Cinema G', '234 Elm St', '000-111-2222', 200).
    cinema(8, 'Cinema H', '901 Birch St', '333-444-5555', 160).

% Кинофильм (id, название, год выпуска, режиссер, жанр)
    movie(1, 'Movie A', 2010, 'Director A', action).
    movie(2, 'Movie B', 2015, 'Director B', comedy).
    movie(3, 'Movie C', 2012, 'Director C', drama).
    movie(4, 'Movie D', 2021, 'Director D', thriller).
    movie(5, 'Movie E', 2014, 'Director E', romance).
    movie(6, 'Movie F', 2011, 'Director F', horror).
    movie(7, 'Movie G', 2020, 'Director G', western).
    movie(8, 'Movie H', 2016, 'Director H', crime).

% Показывают (id кинотеатра, id фильма, дата, время, выручка)
    show(1, 2, '2023-05-10', '19:00', 300).
    show(2, 1, '2023-05-11', '19:30', 400).
    show(3, 3, '2023-05-12', '20:00', 500).
    show(4, 4, '2023-05-13', '20:30', 600).
    show(5, 5, '2023-05-14', '21:00', 700).
    show(6, 6, '2023-05-15', '21:30', 800).
    show(7, 7, '2023-05-16', '22:00', 900).
    show(8, 8, '2023-05-17', '22:30', 200).

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

clauses
    run() :-
        write(" \n"),
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
