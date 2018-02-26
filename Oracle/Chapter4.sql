------CHAPTER 4--------

---Explicit Cursor--
DECLARE
    CURSOR cur_basket IS
            SELECT bi.idBasket, p.type, bi.price, bi.quantity
            FROM bb_basketitem bi INNER JOIN bb_product p
            USING (idProduct)
            WHERE bi.idBasket = 6;
            TYPE type_basket IS RECORD
                (basket bb_basketitem.idBasket%TYPE,
                type bb_product.type%TYPE,
                price bb_basketitem.price%TYPE,
                qty bb_basketitem.quantity%TYPE);
rec_basket type_basket;
lv_rate_num NUMBER(2,2);
lv_tax_num NUMBER(4,2) := 0;
BEGIN
    OPEN cur_basket;
    LOOP
        FETCH cur_basket INTO rec_basket;
    EXIT WHEN cur_basket%NOTFOUND;
    IF rec_basket.type = 'E' THEN lv_rate_num := .05;
    ELSIF rec_basket.type = 'C' THEN lv_rate_num := .03;
    END IF;
    lv_tax_num := lv_tax_num +
    ((rec_basket.price * rec_basket.qty) * lv_rate_num);
    END LOOP;
    CLOSE cur_basket;
      dbms_output.put_line('--------------BEGIN------------------'); 
DBMS_OUTPUT.PUT_LINE(lv_tax_num);
dbms_output.put_line('----------------END------------------'); 
END;


--CURSOR FOR loop--
DECLARE
lv_count NUMBER(9):=0;    
    CURSOR cur_prod IS
           SELECT type, price
            FROM bb_product
            WHERE active = 1
            FOR UPDATE NOWAIT;
    lv_sale bb_product.saleprice%TYPE;
BEGIN

    FOR rec_prod IN cur_prod LOOP
        IF rec_prod.type = 'C' THEN lv_sale := rec_prod.price * .9;
        ELSIF rec_prod.type = 'E' THEN lv_sale := rec_prod.price * .95;
        END IF;
UPDATE bb_product
    SET saleprice = lv_sale
    WHERE CURRENT OF cur_prod;
    lv_count:= lv_count+1;
    END LOOP;
COMMIT;

dbms_output.put_line('--------------BEGIN------------------'); 
DBMS_OUTPUT.PUT_LINE(lv_count);
dbms_output.put_line('----------------END------------------'); 
end;      

---Cursors with Parameters---
DECLARE
    CURSOR cur_order (p_basket NUMBER) IS
            SELECT idBasket, idProduct, price, quantity
            FROM bb_basketitem      
            WHERE idBasket = p_basket;
    lv_bask1_num bb_basket.idbasket%TYPE := 6;
    lv_bask2_num bb_basket.idbasket%TYPE := 10; 
    BEGIN
    dbms_output.put_line('--------------BEGIN------------------'); 
   
    FOR rec_order IN cur_order(lv_bask1_num) LOOP
        DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' ||
        rec_order.idProduct || ' - ' || rec_order.price);
    END LOOP;
    FOR rec_order IN cur_order(lv_bask2_num) LOOP
        DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' ||
        rec_order.idProduct || ' - ' || rec_order.price);
    END LOOP;
dbms_output.put_line('----------------END------------------');     
END;

----Cursor Variables----
DECLARE
cv_prod SYS_REFCURSOR;
rec_item bb_basketitem%ROWTYPE;
rec_status bb_basketstatus%ROWTYPE;
lv_input1_num NUMBER(2) := 2;
lv_input2_num NUMBER(2) := 3;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
    DBMS_OUTPUT.PUT_LINE('ini-'||lv_input1_num||'-'||lv_input2_num||'-');
    IF lv_input1_num = 1 THEN
        OPEN cv_prod FOR SELECT * FROM bb_basketitem
                         WHERE idBasket = lv_input2_num;
        LOOP
            FETCH cv_prod INTO rec_item;
            EXIT WHEN cv_prod%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('rec_item: '||rec_item.idProduct);
        DBMS_OUTPUT.PUT_LINE('loop1-'||lv_input1_num||'-'||lv_input2_num||'-');
        END LOOP;
        ELSIF lv_input1_num = 2 THEN
              OPEN cv_prod FOR SELECT * FROM bb_basketstatus
                                WHERE idBasket = lv_input2_num;
              LOOP
              FETCH cv_prod INTO rec_status;
              EXIT WHEN cv_prod%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('loop2-'||lv_input1_num||'-'||lv_input2_num||'-');
            DBMS_OUTPUT.PUT_LINE(rec_status.idStage || ' - '
            || rec_status.dtstage);
            END LOOP;
        END IF;
        DBMS_OUTPUT.PUT_LINE('final-'||lv_input1_num||'-'||lv_input2_num||'-');
DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
END;


--BULK-PROCESSING FEATURES--

DECLARE
    CURSOR cur_item IS
        SELECT *
        FROM bb_basketitem;
        TYPE type_item IS TABLE OF cur_item%ROWTYPE
        INDEX BY PLS_INTEGER;
        tbl_item type_item;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
    OPEN cur_item;
    LOOP
        FETCH cur_item BULK COLLECT INTO tbl_item LIMIT 1000;
            FOR i IN 1..tbl_item.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE(tbl_item(i).idBasketitem || ' -'
                || tbl_item(i).idProduct);
            END LOOP;
        EXIT WHEN cur_item%NOTFOUND;
    END LOOP;
CLOSE cur_item;
DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
END;
----
DECLARE
    TYPE emp_type IS TABLE OF NUMBER INDEX
    BY BINARY_INTEGER;
    emp_tbl emp_type;
BEGIN
    DBMS_OUTPUT.PUT_LINE(''); 
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
    SELECT empID
        BULK COLLECT INTO emp_tbl
    FROM employees
    WHERE classtype = '100';
FORALL i IN d_emp_tbl.FIRST .. emp_tbl.LAST
    UPDATE employees
    SET raise = salary * .06
    WHERE empID = emp_tbl(i);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
    DBMS_OUTPUT.PUT_LINE(''); 
END;

---EXCEPTION HANDLERS---
DECLARE
TYPE type_basket IS RECORD
        (basket bb_basket.idBasket%TYPE,
        created bb_basket.dtcreated%TYPE,
        qty bb_basket.quantity%TYPE,
        sub bb_basket.subtotal%TYPE);
rec_basket type_basket;

lv_days_num NUMBER(3);
lv_shopper_num NUMBER(3) := 22;
BEGIN
    DBMS_OUTPUT.PUT_LINE(''); 
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
SELECT idBasket, dtcreated, quantity, subtotal
    INTO rec_basket
    FROM bb_basket
        WHERE idShopper = lv_shopper_num
              AND orderplaced = 0;
              
lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;

DBMS_OUTPUT.PUT_LINE('basket : '||rec_basket.basket);
DBMS_OUTPUT.PUT_LINE('created : '||rec_basket.created);
DBMS_OUTPUT.PUT_LINE('qty : '||rec_basket.qty);
DBMS_OUTPUT.PUT_LINE('sub : '||rec_basket.sub);
DBMS_OUTPUT.PUT_LINE('lv_days_num : '||lv_days_num);
DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
EXCEPTION
 WHEN NO_DATA_FOUND THEN
   DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
   DBMS_OUTPUT.PUT_LINE('----------------ERROR------------------'); 
DBMS_OUTPUT.PUT_LINE('');
  WHEN TOO_MANY_ROWS THEN
   DBMS_OUTPUT.PUT_LINE('A problem has ocurred in retrieving your saved basket.');
   DBMS_OUTPUT.PUT_LINE('Tech Support will be notified and contact you via email.'); 
DBMS_OUTPUT.PUT_LINE('----------------ERROR------------------'); 
DBMS_OUTPUT.PUT_LINE('');
END;
---
DECLARE 
 TYPE type_basket IS RECORD (
   basket bb_basket.idBasket%TYPE,
   created bb_basket.dtcreated%TYPE,
   qty bb_basket.quantity%TYPE,
   sub bb_basket.subtotal%TYPE);
 rec_basket type_basket;
 lv_days_num NUMBER(3);
 lv_shopper_num NUMBER(3) := 26;
BEGIN
    DBMS_OUTPUT.PUT_LINE(''); 
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
 SELECT idBasket, dtcreated, quantity, subtotal
  INTO rec_basket
  FROM bb_basket
  WHERE idShopper = lv_shopper_num 
    AND orderplaced = 0;
 lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;

 DBMS_OUTPUT.PUT_LINE('basket : '||rec_basket.basket);
DBMS_OUTPUT.PUT_LINE('created : '||rec_basket.created);
DBMS_OUTPUT.PUT_LINE('qty : '||rec_basket.qty);
DBMS_OUTPUT.PUT_LINE('sub : '||rec_basket.sub);
DBMS_OUTPUT.PUT_LINE('lv_days_num : '||lv_days_num);
 DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
EXCEPTION
 WHEN NO_DATA_FOUND THEN
   DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
   DBMS_OUTPUT.PUT_LINE('----------------ERROR------------------'); 
DBMS_OUTPUT.PUT_LINE('');
 WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Unexpected error');
   DBMS_OUTPUT.PUT_LINE('Error Code = '||SQLCODE); 
   DBMS_OUTPUT.PUT_LINE('Error Message = '||SQLERRM);
   DBMS_OUTPUT.PUT_LINE('----------------ERROR------------------'); 
DBMS_OUTPUT.PUT_LINE('');
END;




