.mode columns
.headers on
create table sailor (sname, rating);
create table boat (bname, color, rating);
create table reservation (sname, bname, day);

insert into sailor values ('Brutus', 1);
insert into sailor values  ('Andy', 8);
insert into sailor values ('Horatio', 7);
insert into sailor values ('Rusty', 8);
insert into sailor values ('Bob', 1);

insert into boat values ('SpeedQueen', 'white', 9);
insert into boat values ('Interlake', 'red', 8);
insert into boat values ('Marine', 'blue', 7);
insert into boat values ('Bay', 'red', 3);

insert into reservation values ('Andy', 'Interlake', 'Monday');
insert into reservation values ('Andy', 'Bay', 'Wednesday');
insert into reservation values ('Andy', 'Marine', 'Saturday');
insert into reservation values ('Rusty', 'Bay', 'Sunday');
insert into reservation values ('Rusty', 'Interlake', 'Wednesday');
insert into reservation values ('Rusty', 'Marine', 'Wednesday');
insert into reservation values ('Bob', 'Bay', 'Monday');