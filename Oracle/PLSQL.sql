DECLARE 
STATE_NAME CHAR(6) :=  'NY';
CAL1 NUMBER(6,2) := 200;
TAX NUMBER(6,2);
DISPLAY CHAR(30);
BEGIN
IF STATE_NAME = 'VA' THEN
    TAX := CAL1 * .6;
    DISPLAY := 'Calculate tax amount using 6%';
    ELSIF STATE_NAME = 'ME' THEN
            TAX := CAL1 *.5;
             DISPLAY := 'Calculate tax amount using 5%';
          ELSIF STATE_NAME = 'NY' THEN
                  TAX := CAL1 *.7;
                   DISPLAY := 'Calculate tax amount using 7%';
ELSE
TAX:= CAL1 * .4;
DISPLAY := 'Calculate tax amount using 4%';
END IF;
DBMS_OUTPUT.PUT_LINE(TAX);
DBMS_OUTPUT.PUT_LINE(DISPLAY);
END;


DECLARE 
promotion   CHAR(1) :=  'A';
CAL1 NUMBER(6,2) := 200;
DISCOUNT NUMBER(6,2);
DISPLAY CHAR(30);
BEGIN
IF promotion = 'A' THEN
    DISCOUNT := CAL1 * .95;
    DISPLAY := 'Calculate discount amount using 5%';
    ELSIF promotion = 'B' THEN
            DISCOUNT := CAL1 * .90;
             DISPLAY := 'Calculate discount amount using 10%';
          ELSIF promotion = 'C' THEN
                  DISCOUNT := CAL1 * .85;
                   DISPLAY := 'Calculate discount amount using 15%';
ELSE
DISCOUNT:= CAL1 * .98;
DISPLAY := 'Calculate discount amount using 2%';
END IF;
DBMS_OUTPUT.PUT_LINE(DISCOUNT);
DBMS_OUTPUT.PUT_LINE(DISPLAY);
DBMS_OUTPUT.PUT_LINE(promotion);
END;












