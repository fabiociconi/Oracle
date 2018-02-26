--Procedures--
/*CREATE[OR REPLACE]PROCEDURE
    procedure_name
    [(parameter1_name[mode] data type,
    parameter2_name[mode] data type,
    ...)]
IS|AS
    declaration section
BEGIN
    executable section
EXCEPTION
    exception handlers
END;*/
CREATE OR REPLACE PROCEDURE ship_cost_sp
(p_qty in number, p_ship out number)
as
begin

    if p_qty > 10 then
        p_ship:=11.00;
    elsif p_qty > 5 then
        p_ship:=8.00;
    else
        P_ship:=5.00;
    end if;           

end ship_cost_sp;
-------------------

---call procedure--
DECLARE 
lv_ship number (6,2);
begin
SHIP_COST_SP(7,lv_ship);
DBMS_OUTPUT.PUT_LINE(''); 
     DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
    DBMS_OUTPUT.PUT_LINE('SHIP_COST_SP : '|| lv_ship);
     DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
end;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--pg187
CREATE OR REPLACE PROCEDURE PHONE_FMT_SP 
(p_phone IN OUT VARCHAR2)
is
BEGIN
--Procedures--
/*CREATE[OR REPLACE]PROCEDURE
    procedure_name
    [(parameter1_name[mode] data type,
    parameter2_name[mode] data type,
    ...)]
IS|AS
    declaration section
BEGIN
    executable section
EXCEPTION
    exception handlers
END;*/



---call procedure--
DECLARE 
lv_ship number (6,2);
begin
SHIP_COST_SP(7,lv_ship);
DBMS_OUTPUT.PUT_LINE(''); 
     DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
     DBMS_OUTPUT.PUT_LINE('SHIP_COST_SP : '|| lv_ship);
     DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');
end;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

create or replace PROCEDURE PHONE_FMT_SP 
(p_phone IN OUT VARCHAR2)
is
BEGIN
DBMS_OUTPUT.PUT_LINE(''); 
  DBMS_OUTPUT.PUT_LINE('--------------BEGIN PROCEDURE------------------'); 
  p_phone := '(' || SUBSTR(p_phone,1,3) || ')' ||
                    SUBSTR(p_phone,4,3) || '-' ||
                    SUBSTR(p_phone,7,4);
     DBMS_OUTPUT.PUT_LINE('----------------END PROCEDURE---------------'); 
DBMS_OUTPUT.PUT_LINE('');
END PHONE_FMT_SP;
--------------------------------------------------------------------------------
--CALL PROCEDURE--
DECLARE
    LV_PHONE_TXT VARCHAR2(13):='1112223333';
BEGIN
    PHONE_FMT_SP(LV_PHONE_TXT);
DBMS_OUTPUT.PUT_LINE(''); 
DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------');
DBMS_OUTPUT.PUT_LINE('LV_PHONE_TXT : '|| LV_PHONE_TXT);
DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');    
END;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--CALLING A PROCEDURE FROM ANOTHER PROCEDURE -PG 188
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE ORDER_TOTAL_SP
(P_BSKTID IN BB_BASKETITEM.IDBASKET%TYPE,
P_CNT OUT NUMBER,
P_SUB OUT NUMBER,
P_SHIP NUMBER,
P_TOTAL NUMBER)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE(''); 
DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------');
DBMS_OUTPUT.PUT_LINE('-ORDER TOTAL PROCEDURE CALLED');
SELECT SUM(QUANTITY), SUM(QUANTITY*PRICE)
    INTO P_CNT, P_SUB
    FROM BB_BASKETITEM
    WHERE IDBASKET=P_BSKTID;
SHIP_COST_SP(P_CNT,P_SHIP);--CALL THE PROCEDURE SHIP_COST_SP
P_TOTAL:=NVL(P_SUB,0)+ NVL(P_SHIP,0);
DBMS_OUTPUT.PUT_LINE('-ORDER TOTAL PROCEDURE ENDED');
DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
DBMS_OUTPUT.PUT_LINE('');  
END ORDER_TOTAL_SP;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
---call procedure--  ORDER_TOTAL_SP
DECLARE
lv_bask_num bb_basketitem.idbasket%TYPE := 12;
lv_cnt_num NUMBER (3);
lv_sub_num NUMBER (8,2);
lv_ship_num NUMBER (8,2);
lv_total_num NUMBER (8,2);
BEGIN
    DBMS_OUTPUT.PUT_LINE(''); 
    DBMS_OUTPUT.PUT_LINE('--------------BEGIN------------------'); 
    
    ORDER_TOTAL_SP(lv_bask_num, lv_cnt_num, lv_sub_num, 
                   lv_ship_num, lv_total_num);
        
    DBMS_OUTPUT.PUT_LINE('lv_cnt_num......: '|| lv_cnt_num);
    DBMS_OUTPUT.PUT_LINE('lv_sub_num......: '|| lv_sub_num);
    DBMS_OUTPUT.PUT_LINE('lv_ship_num.....: '|| lv_ship_num );
    DBMS_OUTPUT.PUT_LINE('lv_total_num....: '|| lv_total_num );
    
    DBMS_OUTPUT.PUT_LINE('----------------END------------------'); 
    DBMS_OUTPUT.PUT_LINE('');
END;

SELECT SUM(quantity), SUM(quantity*price)
FROM bb_basketitem
WHERE idbasket = 12;



