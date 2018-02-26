/***********CARTESIAN JOINS/**************************/
/*(1)Cartesian Join: Traditional Method   */
select isbn, title, cost
from books, warehouses
order by location, title;

select title, name
from books, PUBLISHER;
select * 
from books;
select * 
from PUBLISHER;
/********************************************/
/*(2)Cartesian Join: JOIN Method ???????????*/
select title, name, cost
from books cross JOIN PUBLISHER
order by  title;
/***********CARTESIAN JOINS - END/**************************/
/**/
/**/
/**************EQUALITY JOINS/*****************************/
/* (1) Equality Joins: Traditional Method   */
select title, NAME 
FROM BOOKS, PUBLISHER
WHERE BOOKS.PUBID = PUBLISHER.PUBID;
/********************************************/
/* (2) equality Joins: JOIN Method  */
select title, pubid, name
from PUBLISHER NATURAL JOIN BOOKS;

/*OR*/
SELECT b.title, pubid, p.name
FROM publisher p INNER JOIN books b
USING (pubid);
/***********EQUALITY JOINS  - END/***********************/
/**/
/**/
/************* NON-EQUALITY JOINS/************************/
/* (1) Non-Equality Joins: Traditional Method */
SELECT * FROM PROMOTION;
SELECT b.title, p.gift
from books b, promotion p 
where b.retail BETWEEN p.minretail AND p.MAXRETAIL;

/* (2) Non-Equality Joins: JOIN Method */
SELECT  B.TITLE, P.GIFT
FROM BOOKS B JOIN PROMOTION P
ON B.RETAIL BETWEEN P.MINRETAIL AND P.MAXRETAIL;
/************* NON-EQUALITY - END/************************/
/**/
/**/
/******************** SELF-JOINS/************************/
/* (1) Self-Joins: Traditional Method */
SELECT * FROM CUSTOMERS;
SELECT R.FIRSTNAME, R.LASTNAME, C.LASTNAME  "REFERRED"
FROM CUSTOMERS C, CUSTOMERS R
WHERE C.REFERRED = R.REFERRED;

/* (2) Self-Joins: JOIN Method */

SELECT R.FIRSTNAME, R.LASTNAME, C.LASTNAME "REFERRED"
FROM CUSTOMERS C  JOIN CUSTOMERS R
ON C.REFERRED = R.REFERRED;
/***************** SELF-JOINS- END/***********************/
/**/
/**/
/******************** OUTER JOINS/************************/
/*(1) Outer Joins: Traditional Method   */


/***************** OUTER-JOINS- END/***********************/
/**/
/**/




