-- SELECT ALL TABLES --
select * from  ALIASES;
select * from CRIMINALS; 
select * from CRIMES ;
select * from APPEALS ;
select * from OFFICERS ;
select * from CRIME_OFFICERS;
select * from CRIME_CHARGES;
select * from CRIME_CODES; 
select * from PROB_OFFICERS;
select * from SENTENCES ;
select * from PROB_CONTACT;
select * from CRIMINALS_DW;
---------------------------------------------
/*(1). List the name of each officer who has reported more than the average number of crimes officers
have reported*/
select OFFICER_iD, first, last from OFFICERS
where  OFFICER_iD in
                  (select  OFFICER_iD
                   from  crime_officers JOIN OFFICERS
                   USING (OFFICER_iD)
                   group by OFFICER_iD
                   having count(*) > (SELECT AVG(COUNT(CRIME_ID))
                                      FROM CRIME_OFFICERS
                                      GROUP BY OFFICER_ID));

/*conferindo*/
select    OFFICER_iD, count(*)
from      crime_officers
JOIN      OFFICERS
USING     (OFFICER_iD)
group by   OFFICER_iD;

SELECT     AVG(COUNT(CRIME_ID))
    FROM      CRIME_OFFICERS
    GROUP BY     OFFICER_ID;
select     OFFICER_iD
from     crime_officers
JOIN     OFFICERS
USING    (OFFICER_iD)
group by OFFICER_iD having count(*) > 
          ( SELECT      AVG(COUNT(CRIME_ID))
            FROM     CRIME_OFFICERS
            GROUP BY      OFFICER_ID   );

select  last || ', ' || first
from  OFFICERS
where OFFICER_iD = (select OFFICER_iD
                    from   crime_officers  JOIN OFFICERS  
                    USING  (OFFICER_iD)
                    group by   OFFICER_iD having count(*) >  (SELECT     AVG(COUNT(CRIME_ID))
                                                              FROM       CRIME_OFFICERS    
                                                              GROUP BY     OFFICER_ID   ) );



/*(2). List the criminal names for all criminals who have a 
less than average number of crimes and aren’t listed as violent offenders(violent offender) V sattus.*/


select  last || ', ' || first
from criminals
where upper(v_status) <> 'Y';

select last, first, count(CRIME_ID)
from  CRIMINALS inner join
      CRIMES on CRIMINALS.CRIMINAL_ID = CRIMES.CRIMINAL_ID
where  upper(V_STATUS) <> 'Y'
group by  last, first 
having count(*) < (select avg(count(CRIME_ID))
                   from CRIMES
                   group by   CRIMINAL_ID);

/*conferindo beto*/
select  last || ', ' || first
from   CRIMINALS
where upper(V_STATUS) <> 'Y' and CRIMINAL_ID in (  select   CRIMINALS.CRIMINAL_ID
                                                   from   CRIMINALS
                                                   inner join   CRIMES
                                                   on CRIMINALS.CRIMINAL_ID = CRIMES.CRIMINAL_ID
                                                   group by CRIMINALS.CRIMINAL_ID
                                                   having count(*) < (select  avg(count(CRIME_ID))
                                                                      from  CRIMES
                                                                       group by   CRIMINAL_ID ) );

/*(3)List appeal information for each appeal that has a less than 
average number of days between the filing and hearing dates*/


select APPEAL_ID, (HEARING_DATE - FILING_DATE)
from   APPEALS
where (HEARING_DATE - FILING_DATE) < (select avg(HEARING_DATE - FILING_DATE) 
                                      from APPEALS);


/*beto*/
select hearing_date , filing_date , hearing_date - filing_date as "dif" , avg(hearing_date - filing_date) as "avg" from appeals;


/*(4)List the names of probation officers who have had a less than average number of criminals
assigned.*/


/*vericiar se pego os que tem zero como faco*/
select PROB_ID, first, last 
from   PROB_OFFICERS
where  PROB_ID  in (select PROB_ID 
                   from SENTENCES
                   group by PROB_ID 
                   having count(*) < (select  avg(count(PROB_ID)) 
                                      from SENTENCES
                                      where upper(type) = 'P'
                                      group by PROB_ID  ) );



/**media 3.3'*/
SELECT  avg(count(prob_id)) FROM sentences 
        where upper(type) = 'P'
        group by prob_id;
        
SELECT * FROM prob_officers;
/*9*/

SELECT * FROM sentences ;

/*(5). List each crime that has had the highest number of appeals recorded.*/

select CRIME_ID, count(APPEAL_ID), CODE_DESCRIPTION 
from   APPEALS   join CRIMES 
using(CRIME_ID)  join CRIME_CHARGES
using(CRIME_ID)  join CRIME_CODES
using(CRIME_CODE)
group by CRIME_ID, CODE_DESCRIPTION;

/*SEEE*/

select max(count(appeal_id))  from appeals group by crime_id;


select  count(APPEAL_ID),CRIME_CODE, CODE_DESCRIPTION
from   APPEALS   join CRIMES 
using(CRIME_ID)  join CRIME_CHARGES
using(CRIME_ID)  join CRIME_CODES
using(CRIME_CODE)
group by CRIME_CODE, CODE_DESCRIPTION);


/*(6)List the information on crime charges for each charge that has had a fine above average and
a sum paid below average.*/

/* cronferir*/

select * 
from  CRIME_CHARGES
where FINE_AMOUNT   < (select avg(FINE_AMOUNT) from CRIME_CHARGES)
and   AMOUNT_PAID   < (select avg(AMOUNT_PAID) from CRIME_CHARGES);
---

/*(7)List all the names of all criminals who have had any of the crime code charges involved in
crime ID 10089.*/


select first||' '||last 
from criminals 
where criminal_id in(select criminal_id 
                     from crimes 
                     where crime_id in (select crime_id 
                                        from crime_charges 
                                        where crime_code in(select crime_code 
                                                          from crime_charges 
                                                          where crime_id=10089)));

/* crime code 305*/

/*(8). Use a correlated subquery --to determine which criminals have had at least one probation
period assigned.*/

          
select  CRIMINAL_ID, last, first
         from  CRIMINALS join  SENTENCES
         using(CRIMINAL_ID) 
         where type = 'P'
         group by CRIMINAL_ID, last, first
         having count(type)>=1;
         
        select criminal_id, first||' '||last 
        from criminals 
        where  exists (select criminal_id 
                      from sentences
                       where type = 'P'
                       group by CRIMINAL_Id);
                       

         
               
          

/*SELECT NUM_CONTA_LEGADO, OID_ENTIDADE, OID_TIPO_VINCULO, FLG_REGISTRO_VIGENTE,
      count(*)  qtd
     FROM ods_owner.ODS_CTA_ENTID_PESSOA_CONTA a
  WHERE a.num_conta_legado         is not null
        and a.oid_entidade         is not null
        and a.oid_tipo_vinculo     is not null
        and a.flg_registro_vigente is not null
        and a.NUM_CONTA_LEGADO = a.NUM_CONTA_LEGADO
    GROUP BY CUBE(A.NUM_CONTA_LEGADO,A.OID_ENTIDADE,
                  A.OID_TIPO_VINCULO,A.FLG_REGISTRO_VIGENTE)
    having  count(*)  >= 3 ;   */



select * from &TABELA;

--10
select * from sentences;-- 11
-- crimes12
--criminals11


/*(9). List the names of officers who have booked the highest number of crimes. Note that more
than one officer might be listed.*/


select OFFICER_ID, first, last from OFFICERS
where OFFICER_ID in(
select OFFICER_ID from CRIME_OFFICERS
group by OFFICER_ID
having count(OFFICER_ID)in (select  max(count(*)) from CRIME_OFFICERS
group by OFFICER_ID));

select * from OFFICERS;
select * from CRIME_OFFICERS;


/*(10) The criminal data warehouse contains a copy of the CRIMINALS table that needs to be
updated periodically from the production CRIMINALS table. The data warehouse table is
named CRIMINALS_DW. Use a single SQL statement to update the data warehouse table
to reflect any data changes for existing criminals and to add new criminals.*/


merge into CRIMINALS_DW a
using CRIMINALS B
on (a.CRIMINAL_ID = B.CRIMINAL_ID)
when matched then
update 
set 
a.last      = B.last,
a.first     = B.first,
a.STREET    = B.STREET,
a.CITY      = B.CITY,
a.state     = B.state,
a.ZIP       = B.ZIP,
a.PHONE     = B.PHONE,
a.V_STATUS  = B.V_STATUS,
a.P_STATUS  = B.P_STATUS
when not matched then
insert (CRIMINAL_ID, last, first, 
        STREET, CITY, state, ZIP,  
        PHONE, V_STATUS, P_STATUS)
values (B.CRIMINAL_ID, B.last,
        B.first, B.STREET, B.CITY,
        B.state, B.ZIP, B.PHONE, 
        B.V_STATUS, B.P_STATUS );



/*all tables*/
SELECT * FROM  aliases;
SELECT * FROM criminals; 
SELECT * FROM crimes ;
SELECT * FROM appeals ;
SELECT * FROM  officers ;
SELECT * FROM crime_officers;
SELECT * FROM crime_charges;
SELECT * FROM  crime_codes; 
SELECT * FROM prob_officers;
SELECT * FROM sentences ;
SELECT * FROM prob_contact;
select * from CRIMINALS_DW;

/*1. List the name of each officer who has reported more than the average number of crimes officers
have reported*/
select OFFICER_iD, first, last from OFFICERS
where OFFICER_iD in
(select  OFFICER_iD
  from  crime_officers JOIN OFFICERS
  USING (OFFICER_iD)
  group by OFFICER_iD
  having count(*) > (SELECT AVG(COUNT(CRIME_ID))
  FROM CRIME_OFFICERS
  GROUP BY OFFICER_ID));

/*conferindo*/
select   OFFICER_iD,count(*)
  from     crime_officers
  JOIN   OFFICERS
  USING    (OFFICER_iD)
  group by   OFFICER_iD;

SELECT     AVG(COUNT(CRIME_ID))
    FROM      CRIME_OFFICERS
    GROUP BY     OFFICER_ID;
select     OFFICER_iD
  from     crime_officers
  JOIN   OFFICERS
  USING   (OFFICER_iD)
  group by   OFFICER_iD having count(*) > 
   ( SELECT      AVG(COUNT(CRIME_ID))
    FROM     CRIME_OFFICERS
    GROUP BY      OFFICER_ID   );

select
 last || ', ' || first
from
 OFFICERS
where OFFICER_iD = (  select     OFFICER_iD
  from     crime_officers  JOIN
   OFFICERS  USING   (OFFICER_iD)
  group by   OFFICER_iD having count(*) >    (
    SELECT     AVG(COUNT(CRIME_ID))
    FROM     CRIME_OFFICERS
    GROUP BY     OFFICER_ID   ) );

/*2. List the criminal names for all criminals who have a 
less than average number of crimes and aren’t listed as violent offenders(violent offender) V sattus.*/


select  last || ', ' || first
from criminals
where upper(v_status) <> 'Y';

select last, first, count(CRIME_ID)
from  criminals inner join
 crimes ON criminals.CRIMINAL_ID = crimes.CRIMINAL_ID
where  upper(v_status) <> 'Y'
group by  last, first 
having count(*) < (SELECT AVG(COUNT(CRIME_ID))
    FROM CRIMes
    GROUP BY     criminal_ID);

/*conferindo beto*/
select
 last || ', ' || first
from   criminals
where upper(v_status) <> 'Y' and
 criminal_ID in
 (  select   criminals.criminal_ID
  from   criminals
  inner join   crimes
  ON criminals.CRIMINAL_ID = crimes.CRIMINAL_ID
  group by criminals.criminal_ID
  having count(*) <
  (SELECT  AVG(COUNT(CRIME_ID))
      FROM  CRIMes
      GROUP BY   criminal_ID ) );

/*List appeal information for each appeal that has a less than 
average number of days between the filing and hearing dates*/


select appeal_id, (hearing_date - filing_date) dias
from appeals
where (hearing_date - filing_date) < (select avg(hearing_date - filing_date) from appeals);




/*List the names of probation officers who have had a less than average number of criminals
assigned.*/


/*vericiar se pego os que tem zero como faco*/
select prob_id, first, last 
from prob_officers
where prob_id  in(SELECT prob_id FROM sentences
group by prob_id 
having count(*)<(SELECT  avg(count(prob_id)) FROM sentences 
        where upper(type) = 'P'
        group by prob_id  ) );





/**media 3.3'*/
SELECT  avg(count(prob_id)) FROM sentences 
        where upper(type) = 'P'
        group by prob_id;
        
SELECT * FROM prob_officers;
/*9*/

SELECT * FROM sentences ;

/*5. List each crime that has had the highest number of appeals recorded.*/
/*?????*/

select * from crimes;
where crime_id in(select * from appeals);


/*List the information on crime charges for each charge that has had a fine above average and
a sum paid below average.*/

/* cronferir*/

select * 
from crime_charges
where FINE_AMOUNT < (select avg(fine_amount) from crime_charges)
and amount_paid < (select avg(amount_paid) from crime_charges);
---
/*List all the names of all criminals who have had any of the crime code charges involved in
crime ID 10089.*/


select criminal_id from criminals
where criminal_id in ( select * from crimes ;


select * from criminals;
select * from crimes;
SELECT * FROM crime_charges
where crime_id = 10089;
/* crime code 305*/

/*8. Use a correlated subquery --to determine which criminals have had at least one probation
period assigned.*/



select criminal_id from criminals
where criminal_id =(
SELECT count(*), criminal_id  FROM sentences 
where type = 'P'
group by criminal_id);




--10
select * from sentences;-- 11
-- crimes12
--criminals11

/*
9. List the names of officers who have booked the highest number of crimes. Note that more
than one officer might be listed.*/
select * from OFFICERS;
SELECT * FROM crime_officers;

select officer_id, first, last from officers
where officer_id in(
select officer_id from crime_officers
group by officer_id
having COUNT(officer_id)IN (Select  max(count(*)) from crime_officers
group by officer_id));


/*Note: Use a MERGE statement to satisfy the following request:
.
The criminal data warehouse contains a copy of the CRIMINALS table that needs to be
updated periodically from the production CRIMINALS table. The data warehouse table is
named CRIMINALS_DW. Use a single SQL statement to update the data warehouse table
to reflect any data changes for existing criminals and to add new criminals.*/


MERGE INTO CRIMINALS_DW a
USING CRIMINALS b
ON (a.criminal_id = b.criminal_id)
WHEN MATCHED THEN
UPDATE 
SET 
a.last = b.last,
a.first = b.first,
a.street = b.street,
a.city = b.city,
a.state = b.state,
a.zip = b.zip,
a.phone = b.phone,
a.v_status = b.v_status,
a.p_status = b.p_status
WHEN NOT MATCHED THEN
INSERT (criminal_id, last, first, street, city, state, zip,  phone, 
v_status, p_status)
VALUES (b.criminal_id, b.last, b.first, b.street, b.city,
b.state, b.zip, b.phone, b.v_status, b.p_status );


select * from CRIMINALS_DW;
select * from CRIMINALS;
--rollback;

purge reciclebin;
