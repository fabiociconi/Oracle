/*select p.productname, p.active, d.deptname
from bb_product p, bb_department d 
where p.iddepartment = d.iddepartment;*/

select * from BB_PRODUCT;
SELECT * FROM BB_DEPARTMENT;

--inner join--
SELECT p.productname, p.active, d.deptname
from BB_PRODUCT p inner join BB_DEPARTMENT d
using(IDDEPARTMENT);

--group by--
SELECT deptname, COUNT(idproduct)
from BB_PRODUCT p inner join BB_DEPARTMENT d
using(IDDEPARTMENT)
GROUP BY DEPTNAME;

select * from BB_PRODUCT;
--- AVG---
SELECT avg(price) FROM BB_PRODUCT
where Type = 'C';

---Create table---
CREATE TABLE autos
(   auto_id number(5),
    acquire_date date,
    color varchar2(15),
    CONSTRAINT auto_id_pk UNIQUE(auto_id)
);

describe autos;
desc autos;

---insert---
insert into autos (auto_id, ACQUIRE_DATE, color)
values (45321, '05-MAY-2012', 'gray');
insert into autos (auto_id, ACQUIRE_DATE, color)
values (81433, '12-OCT-2012', 'red');
COMMIT;

select * from autos;

---update---
UPDATE autos 
SET color = 'silver'
where AUTO_ID = 45321;
select * from autos;

---rollback---
rollback;
select * from autos;

--- delete ---
DELETE FROM autos
WHERE AUTO_ID = 45321;
select * from autos;

--- DROP ---
DROP TABLE autos;


---------------

--Hands-on-- Chapter 1

Select * from BB_PRODUCT;

select IDSHOPPER, b.idBasket, b.orderplaced, b.DTORDERED, b.dtcreated
from BB_SHOPPER s inner join BB_BASKET b
using(IDSHOPPER);

select * from BB_SHOPPER;

