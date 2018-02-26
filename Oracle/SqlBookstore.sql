select * from ORDERITEMS;
SELECT * FROM CUSTOMERS;
select * from BOOKAUTHOR;
select * from PUBLISHER;
select * from ORDERS;
select * from BOOKS;
select * from AUTHOR;
select * from ORDERITEMS;
select * from PROMOTION;
select * from STUDENT;

select * from ACCTMANAGER;

select * from books
WHERE RETAIL > 30.00;
SELECT COUNT(*) from books
WHERE RETAIL > 30.00;

select SUM(PAIDEACH * QUANTITY) "TOTAL PROFITT" from ORDERITEMS
JOIN BOOKS USING(ISBN) 
WHERE ORDER# = 1007
GROUP BY QUANTITY


select min(retail) from books
where category = 'COMPUTER';

select * from ORDERS;



SELECT AVG(SUM(PAIDEACH * QUANTITY)) "AVG PROFIT"  FROM ORDERITEMS 
GROUP BY ORDER#;

Select max(PUBDATE)
FROM BOOKS; 


SELECT COUNT(*)  FROM ORDERS
GROUP BY CUSTOMER#;

SELECT COUNT(ISBN), COST,CATEGORY,DISCOUNT,PUBDATE,PUBID,RETAIL,TITLE FROM BOOKS
WHERE CATEGORY = 'COOKING';


SELECT * FROM ORDERS;
SELECT * FROM ORDERITEMS;
SELECT * FROM PUBLISHER;
SELECT * FROM BOOKS;
SELECT * FROM AUTHOR;
SELECT * FROM BOOKAUTHOR;
SELECT * FROM CUSTOMERS;

/*1. List the book title and retail price for all books with a retail price lower than the average retail
price of all books sold by JustLee Books.*/
select TITLE, RETAIL
from BOOKS
group by TITLE, RETAIL
having RETAIL < (select avg(RETAIL) 
                 from BOOKS);


select avg(RETAIL)  from BOOKS;



/*2)Determine which books cost less than the average cost of other books in the same category.*/
select a.TITLE, B.category, a.cost
from BOOKS a, (select category, avg(cost) AAREGECOT 
               from BOOKS 
               group by category)B
where a.category = B.category
and a.cost < B.AAREGECOT;

/*Determine which orders were shipped to the same state as order 1014*/
select ORDER# 
from ORDERS 
where SHIPSTATE =(select SHIPSTATE
                  from ORDERS
                  where ORDER# = 1014);


/*Determine which orders had a higher total amount due than order 1008*/

select ORDER#, sum(PAIDEACH*QUANTITY) AMOUNT 
from ORDERITEMS 
group by ORDER#
having sum(PAIDEACH*QUANTITY) > (select sum(PAIDEACH*QUANTITY) 
                                 from ORDERITEMS
                                 where ORDER# = 1008);

/*Determine which author or authors wrote the books most frequently purchased by customers
of JustLee Books*/

select LNAME, FNAME, ISBN 
from BOOKAUTHOR join AUTHOR 
using(AUTHORID)
where ISBN in(select ISBN 
              from ORDERITEMS 
              group by ISBN
              having sum(QUANTITY) = (select max(sum(QUANTITY))
                                      from ORDERITEMS 
                                      group by ISBN));

/*List the title of all books in the same category as books previously purchased by customer
1007. Don’t include books this customer has already purchased.*/
select TITLE 
from BOOKS 
where category in (select distinct (category) 
                   from BOOKS 
                   where ISBN in (select i.ISBN 
                                  from ORDERITEMS i, ORDERS O
                                  where O.CUSTOMER# = 1007
                                  and i.ORDER#=O.ORDER#))
                  and ISBN not in (select ISBN 
                                   from BOOKS 
                                   where ISBN in(select i.ISBN 
                                   from ORDERITEMS i, ORDERS O 
                                   where O.CUSTOMER# = 1007
                                   and i.ORDER#=O.ORDER#));

/*7. List the shipping city and state for the order that had the longest shipping delay.*/
select SHIPCITY, SHIPSTATE
from ORDERS
group by SHIPCITY, SHIPSTATE
having max(SHIPDATE - ORDERDATE)=(select  max(SHIPDATE - ORDERDATE)
                                  from ORDERS) ;

select SHIPCITY, SHIPSTATE 
from ORDERS 
where SHIPDATE-ORDERDATE = (select max(SHIPDATE-ORDERDATE) 
                            from ORDERS);




/*Determine which customers placed orders for the least expensive book (in terms of regular
retail price) carried by JustLee Books*/

select  a.TITLE, a.RETAIL, a.ISBN, B.ORDER#,c.CUSTOMER#, c.LASTNAME, c.FIRSTNAME 
from BOOKS a, ORDERS B, CUSTOMERS c, ORDERITEMS d
where c.CUSTOMER# = B.CUSTOMER# 
and   d.ORDER#    = B.ORDER# 
and   d.ISBN      = a.ISBN and
a.RETAIL in (select min(RETAIL) 
             from BOOKS);

/**/
select CUSTOMER# 
from CUSTOMERS   join ORDERS 
using(CUSTOMER#) join ORDERITEMS 
using(ORDER#)    join BOOKS 
using(ISBN) 
where RETAIL = (select min(RETAIL) 
                from BOOKS);

/*Determine the number of different customers who have placed an order for books written or
cowritten by James Austin.*/
select count(distinct CUSTOMER#)
             from ORDERS        join CUSTOMERS
             using(CUSTOMER#)   join ORDERITEMS
             using(ORDER#)      join BOOKS
             using(ISBN)        join BOOKAUTHOR
             using(ISBN)        join AUTHOR
             using(AUTHORID) 
             where LNAME ='AUSTIN' ;

select count(distinct ORDERS.CUSTOMER#) 
from ORDERS join ORDERITEMS 
using(ORDER#) 
where ISBN in (select ISBN 
               from ORDERITEMS join BOOKAUTHOR
               using(ISBN)     join AUTHOR
               using(AUTHORID) 
               where LNAME= 'AUSTIN' 
               and FNAME = 'JAMES');

/*Determine which books were published by the publisher of The Wok Way to Cook.*/

select TITLE, ISBN, PUBID, name 
from BOOKS join PUBLISHER
using(PUBID) 
where PUBID in (select PUBID
                from BOOKS
                where TITLE = 'THE WOK WAY TO COOK');

select TITLE 
from BOOKS 
where PUBID = (select PUBID 
               from BOOKS 
               where TITLE = 'THE WOK WAY TO COOK');



