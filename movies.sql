.mode columns
.headers on
create table movie (title, director, actor);
create table schedule (theater, title);

insert into movie values ('Last Tango', 'Bertolucci', 'Brando');
insert into movie values ('Last Tango', 'Bertolucci', 'Winger');
insert into movie values ('Sheltering Sky', 'Bertolucci', 'Winger');
insert into movie values ('Terms of Endearment', 'Brooks', 'Winger');
insert into movie values ('Trouble with Harry', 'Hitchcock', 'MacLaine');
insert into movie values ('Trouble with Harry', 'Hitchcock', 'Hitchcock');



insert into schedule values ('Hillcrest', 'Last Tango');
insert into schedule values ('LJ Village', 'Last Tango');
insert into schedule values ('LJ Village', 'Terms of Endearment');
insert into schedule values ('Horton', 'Last Tango');
insert into schedule values ('Horton', 'Sheltering Sky');
insert into schedule values ('Horton', 'Terms of Endearment');


