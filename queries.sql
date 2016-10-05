/* 
 * Lora Tam
 * ltam
**/

/* PART A: Create Table */

/*
 * .mode columns
 * .headers on
 * create table sailor (
 * 	sname   varchar(20)   not null,
 *	rating  int           not null,
 *	primary key(sname)
 * );
 * create table boat (
 * 	bname   varchar(20)   not null, 
 * 	color   varchar(20)   not null, 
 * 	rating  int           not null,
 * 	primary key(bname)
 * );
 * create table reservation (
 * 	sname   varchar(20)   references sailor(sname), 
 * 	bname   varchar(20)   references boat(bname), 
 * 	day     varchar(20)   not null
 * );
**/

/* PART B: List the contents of relations sailor, boat, and reservation.*/

Select * 
From sailor;

Select *
From boat;

Select * 
From reservation;

/* PART C */

/* PART #1: List all boats reserved on Wednesday and their color */

Select b.bname,b.color
From boat b, reservation r
Where r.day = 'Wednesday' and b.bname = r.bname;

/* PART #2:List the sailors with the highest rating. */

Select s.sname
From sailor s
Where s.rating = (
   Select max(rating)
   From sailor s);

Select s1.sname 
From (
  Select sname,rating 
  From sailor 
  Group by sname) s1 left join 
    (Select sname,rating 
    From sailor
    Group by sname) s2 on
      (s1.sname <> s2.sname) and (s1.rating < s2.rating)
       Where s2.rating is null;

/* PART #3:List all pairs of sailors who have reserved boats on the same day (avoid listings of the form <a, a>, or listing both <a, b> and <b, a>). */

Select distinct s1.sname,s2.sname
From reservation s1, reservation s2
Where s1.day = s2.day and s1.sname < s2.sname;

/* PART #4:For each day, list the number of red boats reserved on that day */

create table alldays (
	day     varchar(20),
	number  int
);

Insert Into alldays (day) VALUES("Monday"), ("Tuesday"), ("Wednesday"), ("Thursday"), ("Friday"), ("Saturday"), ("Sunday");  

Select r.day, count(distinct r.bname) as num
From reservation r,boat b
Where r.bname = b.bname and b.color = 'red'
Group by day
union
Select day, 0 as num
From alldays
Where day not in
   (Select day 
    From reservation r, boat b
    Where r.bname = b.bname and b.color = 'red');

/* PART #5:List the days appearing in the reservation relation for which only red boats are reserved. */

Select Distinct r.day 
From reservation r 
Where day not in 
   (Select r.day 
    From reservation r, boat b 
    Where r.bname = b.bname and b.color <> 'red');

/* PART #6:List the days when no red boat is reserved. As above, days with no reservations should appear in the answer. */

Select distinct a.day
From alldays a
Where not exists
   (Select r.day
    From reservation r ,boat b
    Where a.day = r.day and r.bname = b.bname and b.color = 'red');

/* PART #7:List the days when all red boats are reserved (if there are no red boats, all days of the week qualify). */

Select distinct a.day
From alldays a
Where day not in
   (Select a.day 
    From alldays a, boat b
    Where b.color = 'red' and a.day not in
        (Select r.day 
         From reservation r where r.bname = b.bname));

Select distinct a.day
From alldays a
Where not exists
  (Select * 
   From boat b
   Where b.color = 'red' and not exists
     (Select * 
      From reservation r
      Where r.day = a.day and r.bname = b.bname ));

Select distinct a.day
From alldays a
Where 
   (Select count(*) 
    From boat b
    Where b.color = 'red' and
      (Select count(*) 
       From reservation r
       Where r.day = a.day and r.bname = b.bname) = 0) = 0;

/* PART #8:For each day of the week occurring in the reservation relation, list the average rating of sailors having reserved boats that day */

Select r.day, avg(s.rating)
From sailor s, reservation r
Where s.sname = r.sname
Group by day;

/* PART #9:List the busiest days, i.e. the days with the largest number of reservations. */
Select max(day)
From reservation;

/* PART E */
/* 1. Formulate and run a query to verify that all sailors having reservations
are qualified to sail the boats they reserved */

Select distinct r.sname,s.rating,r.bname,b.rating,r.day 
From reservation r, sailor s, boat b
Where r.sname = s.sname and r.bname = b.bname and s.rating < b.rating;

/* PART F */
/* Switch all Wednesday and Monday reservations, without explicitly
naming the boats involved. */

Update reservation
Set day = 'a'
Where day = 'Monday';

Update reservation
Set day = 'b'
Where day = 'Wednesday';

Update reservation
Set day = 'Monday'
Where day = 'b';

Update reservation
Set day = 'Wednesday'
Where day = 'a';

/*  2. Delete all reservations violating the constraint in (e) above. */

Delete from reservation
Where exists 
   (Select * 
    From sailor s, boat b
    Where s.sname=reservation.sname and b.bname = reservation.bname and s.rating < b.rating);

/* PART G:List again the contents of relation reservation. */
Select *
From reservation;