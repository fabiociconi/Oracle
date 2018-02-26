SELECT * from products;
SELECT * from orders_PROJECT;
SELECT * from customers_PROJECT;
SELECT * from stock;
SELECT * from order_details;
     SELECT sum(a.product_qty * a.product_price)as total,a.product_id
            FROM order_details a INNER JOIN ORDERS_PROJECT b
            USING (order_id)
            WHERE b.customer_id = 1
            group by a.product_id;
            
            SELECT sum(a.product_qty * a.product_price)as total, a.PRODUCT_ID
            FROM order_details a INNER JOIN ORDERS_PROJECT b
            USING (order_id)
            WHERE b.customer_id = 1
            group by a.product_id;    
           

/*****************************************************************************\
|CALCULATE TOTAL AMOUNT THAT CLIENT BOUGHT                                    |
\*****************************************************************************/
CREATE or replace FUNCTION TOT_AMOUNT
( lv_customer_id IN ORDERS_PROJECT.CUSTOMER_ID%type) 
   RETURN NUMBER 
   IS lv_total_amount NUMBER(14,2);
   BEGIN 
      SELECT sum( b.product_qty * b.product_price)as total
      INTO lv_total_amount 
      FROM ORDERS_PROJECT a, ORDER_DETAILS b 
      WHERE a.CUSTOMER_ID = lv_customer_id
      and a.order_date = sysdate;
      RETURN(lv_total_amount); 
    END TOT_AMOUNT;
/*****************************************************************************\
call function - test
\*****************************************************************************/

DECLARE 
lv_customer_id number (3):=&customer;
lv_total_amount number (14,2);
lv_total_amount_after number (14,2);
begin
lv_total_amount:=TOT_AMOUNT(lv_customer_id);
CALC_DISCOUNT(LV_CUSTOMER_ID);
DBMS_OUTPUT.PUT_LINE(''); 
     DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
     DBMS_OUTPUT.PUT_LINE('Customer      : '|| lv_customer_id); 
     DBMS_OUTPUT.PUT_LINE('total Amount : '|| lv_total_amount);
     DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
end;

/*****************************************************************************\
|CALCULATE DISCOUNT DEPEND ON THE VALUE OF TOTAL AMOUT BHOUGHT BY THE COSUMER |
\*****************************************************************************/

     SELECT sum(a.product_qty * a.product_price)as total
            FROM order_details a INNER JOIN ORDERS_PROJECT b
            USING (order_id)
            where b.CUSTOMER_ID =&customer
            group by A.PRODUCT_ID;


create or replace PROCEDURE CALC_DISCOUNT
(p_customer_id IN NUMBER)
AS
  CURSOR CURSOR_TOT_PURCHASE IS
     SELECT sum(a.product_qty * a.product_price)as total
            FROM order_details a INNER JOIN ORDERS_PROJECT b
            USING (order_id)
            WHERE b.customer_id = p_customer_id
            group by a.product_id;    
            total number(14,2);
BEGIN
open CURSOR_TOT_PURCHASE;
LOOP
  FETCH CURSOR_TOT_PURCHASE INTO total;
  if  TOTAL > 200 then
     total:= total * .20;
 end if;
    EXIT WHEN CURSOR_TOT_PURCHASE%NOTFOUND;
END LOOP;
CLOSE CURSOR_TOT_PURCHASE;

END CALC_DISCOUNT;  


