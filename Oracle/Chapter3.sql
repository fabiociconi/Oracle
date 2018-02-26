------CHAPTER 3--------

--Using the %TYPE Attribute--

DECLARE
        lv_basket_num bb_basket.idBasket%TYPE;
        lv_created_date bb_basket.dtcreated%TYPE;
        lv_qty_num bb_basket.quantity%TYPE;
        lv_sub_num bb_basket.subtotal%TYPE;
        lv_days_num NUMBER(3);
BEGIN
        SELECT idBasket, dtcreated, quantity, subtotal
            INTO lv_basket_num, lv_created_date, lv_qty_num, lv_sub_num
            FROM bb_basket
            WHERE idShopper = 25
            AND orderplaced = 0;

lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;
DBMS_OUTPUT.PUT_LINE(lv_basket_num || ' * ' ||
lv_created_date || ' * ' || lv_qty_num || ' * ' ||
lv_sub_num || ' * ' || lv_days_num);
END;


---The Role of the %ROWTYPE Attribute--

DECLARE
    rec_shopper bb_shopper%ROWTYPE;
BEGIN
    SELECT *
        INTO rec_shopper
        FROM bb_shopper
        WHERE idshopper = 25;
DBMS_OUTPUT.PUT_LINE(rec_shopper.lastname);
DBMS_OUTPUT.PUT_LINE(rec_shopper.address);
DBMS_OUTPUT.PUT_LINE(rec_shopper.email);
END;

DECLARE
    rec_dept bb_department%ROWTYPE;
BEGIN
    rec_dept.iddepartment := 4;
    rec_dept.deptname := 'Teas';
    rec_dept.deptdesc := 'Premium teas';
    DBMS_OUTPUT.PUT_LINE(rec_dept.deptname);
END;


---Associative Array Attributes---

DECLARE
    TYPE type_roast IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    tbl_roast type_roast;
    lv_tot_num NUMBER := 0;
    lv_cnt_num NUMBER := 0;
    lv_avg_num NUMBER;
    
    lv_samp1_num NUMBER(5,2) := 6.22;
    lv_samp2_num NUMBER(5,2) := 6.13;
    lv_samp3_num NUMBER(5,2) := 6.27;
    lv_samp4_num NUMBER(5,2) := 6.16;
    lv_samp5_num NUMBER(5,2);
BEGIN
    tbl_roast(1) := lv_samp1_num;
    tbl_roast(2) := lv_samp2_num;
    tbl_roast(3) := lv_samp3_num;
    tbl_roast(4) := lv_samp4_num;
    tbl_roast(5) := lv_samp5_num;
    FOR i IN 1..tbl_roast.COUNT LOOP
        IF tbl_roast(i) IS NOT NULL THEN
           lv_tot_num := lv_tot_num + tbl_roast(i);
        lv_cnt_num := lv_cnt_num + 1;
        END IF;
    END LOOP;
    lv_avg_num := lv_tot_num / lv_cnt_num;
    dbms_output.put_line('--------------BEGIN------------------'); 
    DBMS_OUTPUT.PUT_LINE('lv_tot_num:' || lv_tot_num);
    DBMS_OUTPUT.PUT_LINE('lv_cnt_num:' ||lv_cnt_num);
    DBMS_OUTPUT.PUT_LINE('tbl_roast:' ||tbl_roast.COUNT);
    DBMS_OUTPUT.PUT_LINE('lv_avg_num:' ||lv_avg_num);
     dbms_output.put_line('----------------END------------------'); 
END;
---------

DECLARE
    TYPE type_basketitems IS TABLE OF bb_basketitem%ROWTYPE
    INDEX BY BINARY_INTEGER;
    tbl_items type_basketitems;
    lv_ind_num NUMBER(3) := 1 ;
    lv_id_num bb_basketitem.idproduct%TYPE := 7;
    lv_price_num bb_basketitem.price%TYPE := 10.80;
    lv_qty_num bb_basketitem.quantity%TYPE := 2;
    lv_opt1_num bb_basketitem.option1%TYPE := 2;
    lv_opt2_num bb_basketitem.option2%TYPE := 3;
BEGIN
    tbl_items(lv_ind_num).idproduct := lv_id_num;
    tbl_items(lv_ind_num).price := lv_price_num;
    tbl_items(lv_ind_num).quantity := lv_qty_num;
    tbl_items(lv_ind_num).option1 := lv_opt1_num;
    tbl_items(lv_ind_num).option2 := lv_opt2_num;

    dbms_output.put_line('--------------BEGIN------------------'); 
    DBMS_OUTPUT.PUT_LINE(lv_ind_num);
    DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).idproduct);
    DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).price);
    dbms_output.put_line('----------------END------------------'); 
END;












