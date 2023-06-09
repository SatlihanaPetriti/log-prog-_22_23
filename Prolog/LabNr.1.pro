% Кинотеатр (id, название, адрес, телефон, количество мест)
cinema(1, 'Cinema A', '123 Main St', '123-456-7890', 100).
cinema(2, 'Cinema B', '456 Elm St', '987-654-3210', 150).
cinema(3, 'Cinema C', '789 Oak St', '555-555-5555', 200).
cinema(4, 'Cinema D', '789 Maple St', '111-222-3333', 120).
cinema(5, 'Cinema E', '321 Pine St', '444-555-6666', 180).
cinema(6, 'Cinema F', '567 Oak St', '777-888-9999', 150).
cinema(7, 'Cinema G', '234 Elm St', '000-111-2222', 200).
cinema(8, 'Cinema H', '901 Birch St', '333-444-5555', 160).


% Кинофильм (id, название, год выпуска, режиссер, жанр)
movie(1, 'Movie A', 2010, 'Director A', 'Action').
movie(2, 'Movie B', 2011, 'Director B', 'Comedy').
movie(3, 'Movie C', 2012, 'Director C', 'Drama').
movie(4, 'Movie D', 2013, 'Director D', 'Thriller').
movie(5, 'Movie E', 2014, 'Director E', 'Romance').
movie(6, 'Movie F', 2015, 'Director F', 'Horror').
movie(7, 'Movie G', 2016, 'Director G', 'Western').
movie(8, 'Movie H', 2017, 'Director H', 'Crime').

% Показывают (id кинотеатра, id фильма, дата, время, выручка)
show(1, 1, '2023-05-10', '19:00', 300).
show(2, 2, '2023-05-11', '19:30', 400).
show(3, 3, '2023-05-12', '20:00', 500).
show(4, 4, '2023-05-13', '20:30', 600).
show(5, 5, '2023-05-14', '21:00', 700).
show(6, 6, '2023-05-15', '21:30', 800).
show(7, 7, '2023-05-16', '22:00', 900).
show(8, 8, '2023-05-17', '22:30', 200).

% Примеры доменов(жанр)
movie_genre('Action').
movie_genre('Horror').
movie_genre('Thriller').
movie_genre('Crime').
movie_genre('Drama').
movie_genre('Comedy').
movie_genre('Western').
movie_genre('Romance').

% Правило: Адрес кинотеатра, показывающий фильм определенного жанра
address_of_cinema_genre(IdCinema, Genre) :-
    cinema(IdCinema, _, Address, Phone, _),
    show(IdCinema, IdMovie, _, _, _),
    movie(IdMovie, _, _, _, Genre).

%Правило: Кинотеатр, показывающий определенный фильм.
cinema_show_genre(IdCinema, Genre) :- 
show(IdCinema, IdMovie, _, _, _), 
movie(IdMovie, _, _, _, Genre).
cinema_show_date(IdCinema, Date) :- show(IdCinema, _, Date, _, _).
cinema_show_time(IdCinema, Time) :- show(IdCinema, _, _, Time, _).
cinema_revenue(IdCinema, Revenue) :- show(IdCinema, _, _, _, Revenue).





