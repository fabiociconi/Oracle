CREATE OR REPLACE PROCEDURE DDPROJ_SP
( p_projectid IN dd_project.idproj%TYPE,
  p_project OUT dd_project%ROWTYPE) 
AS
BEGIN
DBMS_OUTPUT.PUT_LINE('');
 DBMS_OUTPUT.PUT_LINE('--------------BEGIN PROCEDURE------------------'); 
  SELECT * INTO p_project
  FROM dd_project
  WHERE idproj = p_projectid;
   DBMS_OUTPUT.PUT_LINE('----------------END PROCEDURE---------------'); 
DBMS_OUTPUT.PUT_LINE('');
END DDPROJ_SP;


DECLARE 
lv_projectid NUMBER (3):=&id;
lv_project dd_project%rowtype;
BEGIN
  ddproj_sp(lv_projectid, lv_project);
dbms_output.put_line(''); 
     dbms_output.put_line('--------------BEGIN------------------'); 
     dbms_output.put_line('id      : '|| lv_project.idproj); 
     dbms_output.put_line('project : '|| lv_project.projname);
     dbms_output.put_line('start : '|| lv_project.projstartdate);
     dbms_output.put_line('end : '|| lv_project.projenddate);
     dbms_output.put_line('goal : '|| lv_project.projfundgoal);
     dbms_output.put_line('coor : '|| lv_project.projcoord);
     dbms_output.put_line('----------------END------------------'); 
dbms_output.put_line('');
END;


  SELECT *   FROM dd_project;


--exercice2
CREATE OR REPLACE PROCEDURE ddckbal_sp
  ( p_pledgeid IN dd_pledge.idpledge%TYPE,
    p_pledgeamt OUT dd_pledge.pledgeamt%TYPE,
    p_payamt OUT dd_payment.payamt%TYPE) AS
  BEGIN
DBMS_OUTPUT.PUT_LINE('');
 DBMS_OUTPUT.PUT_LINE('--------------BEGIN PROCEDURE------------------'); 
--pledge amount
    SELECT pledgeamt INTO p_pledgeamt
    FROM dd_pledge
    WHERE idpledge = p_pledgeid;
--payment total
  SELECT SUM(payamt) INTO p_payamt
  FROM dd_payment
  WHERE idpledge= p_pledgeid;
   DBMS_OUTPUT.PUT_LINE('----------------END PROCEDURE---------------'); 
DBMS_OUTPUT.PUT_LINE('');
END ddckbal_sp;


DECLARE 
lv_pledgeid NUMBER (3):=&id;
lv_pledgeamt dd_pledge.pledgeamt%TYPE;
lv_payamt dd_payment.payamt%TYPE;
lv_remain dd_pledge.pledgeamt%TYPE;
BEGIN
  DDCKBAL_SP(lv_pledgeid, lv_pledgeamt,lv_payamt);
 lv_remain := lv_pledgeamt-lv_payamt;
DBMS_OUTPUT.PUT_LINE(''); 
     DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
     DBMS_OUTPUT.PUT_LINE('id............:'|| lv_pledgeid); 
     DBMS_OUTPUT.PUT_LINE('pledge Amount.:'|| lv_pledgeamt);
     DBMS_OUTPUT.PUT_LINE('pledge total..:'|| lv_payamt);
     DBMS_OUTPUT.PUT_LINE('remaing.....:'|| lv_remain);    
     DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
END;


SELECT * 
    FROM dd_pledge;

  SELECT *
  FROM dd_payment;
  SELECT SUM(payamt) INTO p_payamt
  FROM dd_payment;
  
SELECT * FROM mm_rental
WHERE  member_id = 13;
  
SELECT * FROM mm_movie
WHERE  movie_id = 12;
create or replace PROCEDURE movie_rent_sp
(
    p_movie_id IN mm_movie.movie_id%type,
    p_member_id IN mm_member.member_id%type,
    p_payment_method IN mm_pay_type.payment_methods%type
)
AS  
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN PROCEDURE------------------'); 

    INSERT INTO mm_rental(rental_id, member_id, movie_id, checkout_date, checkin_date, payment_methods_id)
                VALUES(13,p_member_id, p_movie_id, SYSDATE, SYSDATE, p_payment_method);             
                
    UPDATE mm_movie
    SET movie_qty = (movie_qty - 1) 
    WHERE movie_id = p_movie_id;
    DBMS_OUTPUT.PUT_LINE('----------------END PROCEDURE---------------'); 
    DBMS_OUTPUT.PUT_LINE('');    
END;

DECLARE 
lv_member_id NUMBER (2):=&memberid;
lv_movie_id NUMBER (2):=&movieid;
lv_payamt NUMBER (1):=&typepay;
BEGIN
  movie_rent_sp(lv_member_id, lv_movie_id, lv_payamt);

DBMS_OUTPUT.PUT_LINE(''); 
     DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
     DBMS_OUTPUT.PUT_LINE('movie ID.........:'|| lv_member_id); 
     DBMS_OUTPUT.PUT_LINE('Member ID........:'|| lv_movie_id);
     DBMS_OUTPUT.PUT_LINE('method..............:'|| lv_payamt);
     DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
END;

SELECT MAX(movie_qty) FROM mm_movie;











CREATE OR REPLACE PROCEDURE MOVIE_RETURN_SP
   (p_rental_id IN mm_rental.rental_id%type,
    p_movie_id IN mm_movie.movie_id%type   )
AS
BEGIN
 DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN PROCEDURE------------------'); 
   INSERT INTO mm_rental(rental_id, checkin_date)
      values(p_rental_id, SYSDATE);
   UPDATE mm_movie
      SET movie_qty = movie_qty + 1
      WHERE movie_id = p_movie_id;
          DBMS_OUTPUT.PUT_LINE('----------------END PROCEDURE---------------'); 
    DBMS_OUTPUT.PUT_LINE('');
END;






DECLARE 
lv_member_id NUMBER (2):=&memberid;
lv_movie_id NUMBER (2):=&movieid;
BEGIN
  MOVIE_RETURN_SP(lv_member_id, lv_movie_id);

DBMS_OUTPUT.PUT_LINE(''); 
     DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
     DBMS_OUTPUT.PUT_LINE('movie ID.........:'|| lv_member_id); 
     DBMS_OUTPUT.PUT_LINE('Member ID........:'|| lv_movie_id);
     DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
END;
