DECLARE
lv_ord_date DATE;
lv_last_txt VARCHAR2(25);
lv_qty_num NUMBER(2);
lv_shpflag_bln BOOLEAN;
lv_bln_txt VARCHAR2(5);
BEGIN
lv_ord_date := '12-JUL-2012';
lv_last_txt := 'Brown';
lv_qty_num  := 3;
lv_shpflag_bln  := TRUE;
dbms_output.put_line(lv_ord_date);
/*DBMS_OUTPUT.PUT_LINE(lv_ord_date);*/
dbms_output.put_line(lv_last_txt);
DBMS_OUTPUT.PUT_LINE(lv_qty_num);
IF lv_shpflag_bln THEN
    lv_bln_txt := 'OK';
END IF;
dbms_output.put_line(lv_bln_txt);
END;
---
declare
"2 bucks" number (5,2);
"VAR" number(5,2);
"var" number(5,2);
Begin
"2 bucks"   := 2.00;
"VAR"   := 5;
"var"   := 10;
dbms_output.put_line("2 bucks");
dbms_output.put_line(var);
dbms_output.put_line("var");
End;
---
---errro because need to convert to char
/*Declare
lv_amt_num number(8,2);
Begin
lv_amt_num  := $5,246.22;
dbms_output.put_line(lv_amt_num);
end;*/
--------------------------------------------------
declare
lv_amt_num number(8,2);
begin
lv_amt_num :=   285.85;
dbms_output.put_line(to_char(lv_amt_num,'$99.99'));
dbms_output.put_line(to_char(lv_amt_num,'$999.99'));
dbms_output.put_line(to_char(lv_amt_num,'$999'));
end;
--------------------------------------------------
--options to include quotes
declare
lv_title_txt varchar2(15);
begin
lv_title_txt    := 'Donor''s Best';
dbms_output.put_line(lv_title_txt);
lv_title_txt    := q'(Donor's Best)';
dbms_output.put_line(lv_title_txt);
lv_title_txt    := q'(Donor's Best')';
dbms_output.put_line(lv_title_txt);
end;
--------------------------------------------------
--Variable Initialization
--------------------------------------------------

declare
lv_ord_date date    := Sysdate;
lv_last_txt varchar2(25)    := 'Fabio';
lv_qty_num number(2)    := 0;
lv_shipflag_bln boolean := false;
begin
dbms_output.put_line(lv_ord_date);
dbms_output.put_line(lv_last_txt);
dbms_output.put_line(lv_qty_num);
end;
--------------------------------------------------
--NOT NULL and CONSTANT
--------------------------------------------------
declare
lv_shipcntry_txt varchar2(15) not null := 'US';
lv_taxrate_num constant Number(2,2) := .07;
begin
dbms_output.put_line(lv_shipcntry_txt);
dbms_output.put_line(lv_taxrate_num);
end;
--------------------------------------------------
--Calculations with Scalar Variables
--------------------------------------------------

DECLARE
lv_taxrate_num CONSTANT NUMBER(2,2) := .06;
lv_total_num NUMBER(6,2) := 50;
lv_taxamt_num NUMBER(4,2);
BEGIN
lv_taxamt_num := lv_total_num * lv_taxrate_num;
DBMS_OUTPUT.PUT_LINE(lv_taxamt_num);
END;
--------------------------------------------------
--Using SQL Functions with Scalar Variables
--------------------------------------------------
declare
lv_first_date date  := '20-oct-2012';
lv_second_date date :=  '20-sep-2010';
lv_months_num number(3);
begin
lv_months_num   := months_between(lv_first_date,lv_second_date);
DBMS_OUTPUT.PUT_LINE(lv_months_num);
end;
--------------------------------------------------
--DECISION STRUCTURES
--------------------------------------------------
--Simple IF Statements
declare
lv_state_txt char(2)    := 'VA';
lv_sub_num number(5,2)  := 100;
lv_tax_num number(4,2)  := 0;
begin
if lv_state_txt = 'VA' then
lv_tax_num  := lv_sub_num * .06;
end if;
dbms_output.put_line(lv_tax_num);
end;

--IF/THEN/ELSE Statements
declare
lv_sate_txt char(2) := 'NC';
lv_sub_num number(5,2)  := 100;
lv_tax_num number(4,2)  := 0;
begin
if lv_sate_txt = 'VA' then
    lv_tax_num  := lv_sub_num * .06;
else
    lv_tax_num  := lv_sub_num * .04;
end if;
    dbms_output.put_line(lv_tax_num);
end;
--or--
-- IF/THEN Versus IF
declare
lv_state_txt char(2)    := 'NC';
lv_sub_num number(5,2)  := 100;
lv_tax_num number(4,2)  := 0;
begin
IF lv_state_txt = 'VA' THEN
    lv_tax_num := lv_sub_num * .06;
else
    lv_tax_num := lv_sub_num * .04;
END IF;
dbms_output.put_line(lv_tax_num);
end;

---IF/THEN/ELSIF/ELSE
declare
lv_state_txt char(2) := 'ME';
lv_sub_num number(5,2)  := 100;
lv_tax_num number(4,2)  := 0;
Begin
if lv_state_txt     = 'VA' then
    lv_tax_num   := lv_sub_num * .06;
elsif  lv_state_txt = 'ME' then    
     lv_tax_num     := lv_sub_num * .05;
elsif  lv_state_txt = 'NY' then    
     lv_tax_num     := lv_sub_num * .07;
else
    lv_tax_num   := lv_sub_num * .04;
end if;
dbms_output.put_line(lv_tax_num);
End;


---CASE Statements

declare
lv_state_txt char(2) := 'ME';
lv_sub_num number(5,2)  := 100;
lv_tax_num number(4,2)  := 0;
begin
case lv_state_txt
    when 'VA' THEN lv_tax_num   := lv_sub_num * .06;
    when 'ME' THEN lv_tax_num   := lv_sub_num * .05;
    when 'NY' THEN lv_tax_num   := lv_sub_num * .07;
    ELSE lv_tax_num := lv_sub_num * .04;
end case;
dbms_output.put_line(lv_tax_num);
end;

--- Searched CASE Statements
declare
lv_state_txt char(2) := 'ME';
lv_zip_txt char(5)  := '23321';
lv_sub_num number(5,2)  := 100;
lv_tax_num number(4,2)  := 0;
begin
case 
    when lv_zip_txt = '2331' THEN 
        lv_tax_num   := lv_sub_num * .02;
    when lv_state_txt = 'ME' THEN 
        lv_tax_num   := lv_sub_num * .06;
    ELSE 
    lv_tax_num := lv_sub_num * .04;
end case;
dbms_output.put_line(lv_tax_num);
end;

---Using a CASE Expression---

declare
lv_state_txt char(2) := 'ME';
lv_sub_num number(5,2)  := 100;
lv_tax_num number(4,2)  := 0;
begin
    lv_tax_num  := case lv_state_txt
        when 'VA' THEN lv_sub_num * .04
        when 'ME' THEN lv_sub_num * .05
        when 'NY' THEN lv_sub_num * .07
        else lv_sub_num * .04
    end;
dbms_output.put_line(lv_tax_num);
end;    
--or--

DECLARE
lv_state_txt CHAR(2) := 'ME';
lv_sub_num NUMBER(5,2) := 100;
lv_tax_num NUMBER(4,2) := 0;
BEGIN
lv_tax_num :=
CASE
WHEN lv_state_txt = 'VA' OR lv_state_txt = 'TX' THEN .06
WHEN lv_state_txt = 'ME' OR lv_state_txt = 'WY' THEN .05
ELSE 0
END * lv_sub_num;
DBMS_OUTPUT.PUT_LINE(lv_tax_num);
END;

--Basic Loops
declare
lv_cnt_num number(2) := 1;
begin
loop
dbms_output.put_line(lv_cnt_num);
exit when lv_cnt_num >=5;
lv_cnt_num := lv_cnt_num + 1;
end loop;
end;

--WHILE Loops--
declare
lv_cnt_num number(2) := 1;
begin
while lv_cnt_num <= 5 loop
    dbms_output.put_line(lv_cnt_num);
    lv_cnt_num := lv_cnt_num + 1;
end loop;
end;

---FOR Loops


declare
lv_cnt_num number(2) := 1;
begin
for  i in 1..5 loop
    dbms_output.put_line(i);

end loop;
end;

DECLARE
lv_upper_num NUMBER(3) := 3;
BEGIN
FOR i IN 1..lv_upper_num LOOP
DBMS_OUTPUT.PUT_LINE(i);
END LOOP;
END;

DECLARE
lv_upper_num NUMBER(3) := 3;
BEGIN
FOR i IN REVERSE 1..lv_upper_num LOOP
DBMS_OUTPUT.PUT_LINE(i);
END LOOP;
END;

DECLARE
BEGIN
FOR i IN 1..2 LOOP
DBMS_OUTPUT.PUT_LINE (i*5);
END LOOP;
END;

--CONTINUE Statements

DECLARE 
lv_cnt_num  NUMBER(3):= 0;
BEGIN
FOR i IN 1..25 LOOP
    CONTINUE WHEN MOD(I,5)<>0;
    dbms_output.put_line('loop i value : ' || i);
    lv_cnt_num := lv_cnt_num + 1;
END LOOP;
dbms_output.put_line('final execution count: '  || lv_cnt_num);
END;

-- Nested Loops--

DECLARE
begin
for oi in 1..3 loop
 dbms_output.put_line('outher loop');
 for ii in 1..2 loop
  dbms_output.put_line('iiner loop');
 end loop;
end loop;
end;

declare
BEGIN
<<outer>>
FOR oi IN 1..3 LOOP
DBMS_OUTPUT.PUT_LINE('Outer Loop');
<<inner>>
FOR ii IN 1..2 LOOP
IF oi <> 2 THEN CONTINUE outer; END IF;
DBMS_OUTPUT.PUT_LINE('Inner Loop');
END LOOP;
END LOOP;
END;