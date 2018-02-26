    DECLARE
      num_of_payments NUMBER(2):=5;       
      payment_num NUMBER(2);           
      start_date DATE:= sysdate;               
      date_due DATE;                  
      monthly_payment_amt NUMBER(8,2):=200.00; 
      donation_balance NUMBER(8,2);     
      pledgeamt NUMBER(8,2):=300.00;            
    begin
      monthly_payment_amt := pledgeamt / num_of_payments;  
      date_due := start_date;
      donation_balance := (pledgeamt - monthly_payment_amt);
      payment_num := 0;  
         dbms_output.put_line('--------------BEGIN------------------');   
     LOOP
      payment_num := payment_num +1;  
      date_due := add_months(date_due,1);  

    DBMS_OUTPUT.PUT_LINE('Payment number: ' || payment_num || ' Due Date: '
    || date_due || ' Payment Amount: ' || monthly_payment_amt || ' Balance: ' 
    || to_char(donation_balance,'$9999.99'));
    donation_balance := donation_balance - monthly_payment_amt;
      
      EXIT WHEN donation_balance < 0;
       
    END LOOP;
    dbms_output.put_line('----------------END------------------');   

    END;






DECLARE
  lv_payment NUMBER(2);
  lv_amount NUMBER(8,2);
  lv_match NUMBER(8,2);
  
BEGIN
  lv_amount := 300.00;
  lv_payment := 0;
  lv_match := CASE lv_payment
    WHEN 0 THEN lv_amount * .25
    WHEN 1 THEN lv_amount * .50
    WHEN 2 THEN lv_amount * 1
    ELSE lv_amount * 0
END;
 dbms_output.put_line('-----------------------------');
  DBMS_OUTPUT.PUT_LINE(lv_match);
   dbms_output.put_line('-----------------------------');
END;


declare
lv_rating char(5);
lv_qtd number(10);

begin

lv_qtd:=33;
if  lv_qtd >= 35  then
    lv_rating  := 'high';
elsif (lv_qtd >= 21 and lv_qtd <= 34) then
    lv_rating  := 'mid';
elsif (lv_qtd >= 6 and lv_qtd <= 20) then
  lv_rating  := 'low';
else
 lv_rating  := 'dump';
end if;
 dbms_output.put_line('-----------------------------');
    dbms_output.put_line(lv_rating);
     dbms_output.put_line('-----------------------------');
end;


declare
lv_total_purch number(5) := 155;
lv_rating char(10);
--lv_tax_num number(4,2)  := 0;
begin

if  lv_total_purch >= 200  then
    lv_rating  := 'high';
elsif (lv_total_purch >= 99 and lv_total_purch <= 199) then
    lv_rating  := 'mid';
else
 lv_rating  := 'low';
end if;
 dbms_output.put_line('-----------------------------');
    dbms_output.put_line(lv_rating);
     dbms_output.put_line('-----------------------------');
end;


declare
lv_valu_due BOOLEAN;
lv_payment number(8,2);
lv_balance number(8,2);
BEGIN
lv_balance := 300.00;
lv_payment := 500.00;
If (lv_payment > lv_balance) then
    lv_valu_due := true;
     dbms_output.put_line('-----------------------------');
    dbms_output.put_line ('TRUE');
     dbms_output.put_line('-----------------------------');
    
else
    lv_valu_due:= false;
     dbms_output.put_line('-----------------------------');
    dbms_output.put_line ('false');
     dbms_output.put_line('-----------------------------');
end if;
  
end;







declare
lv_qtd number(5);
lv_member char(1);
lv_cost number(8,2);
--lv_nonmember_cost number(8,2);
begin
lv_qtd := 1;
lv_member :='N';
CASE
WHEN lv_qtd >= 10 THEN 
      if lv_member  = 'Y' then
         lv_cost:= 9.00;
      else
         lv_cost:= 12.00;
      end if;
WHEN (lv_qtd >= 7 and lv_qtd <= 9) THEN 
        if lv_member  = 'Y' then
         lv_cost:= 7.00;
      else
         lv_cost:= 10.00;
      end if;
WHEN (lv_qtd >= 4 and lv_qtd < 7) THEN 
      if lv_member  = 'Y' then
         lv_cost:= 5.00;
      else
         lv_cost:= 7.50;
      end if;
else
     if lv_member  = 'Y' then
         lv_cost:= 3.00;
      else
         lv_cost:= 5.00;
      end if;
end case;
 dbms_output.put_line('-----------------------------');
    dbms_output.put_line('Member(Y/N): '|| LV_MEMBER);
        dbms_output.put_line('Quantity:' || lv_qtd);
            dbms_output.put_line('Total Cost: '||to_char(lv_cost,'$99.99'));
             dbms_output.put_line('-----------------------------');
end;


