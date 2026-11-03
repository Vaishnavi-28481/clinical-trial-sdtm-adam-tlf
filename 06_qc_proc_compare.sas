/* Independent second version of ADSL built with PROC SQL */
proc sql;
  create table adsl_qc as
  select STUDYID, USUBJID, SUBJID, SITEID, AGE,
         case when AGE < 55 then "<55" else ">=55" end as AGEGR1 length=5,
         SEX, RACE, ARM as TRT01P,
         case when ARMCD = "DRUG" then 1 else 2 end as TRT01PN,
         input(RFSTDTC, yymmdd10.) as TRTSDT format=date9.,
         case when not missing(RFSTDTC) then "Y" else "N" end as SAFFL length=1
  from dm
  order by USUBJID;
quit;

proc sort data=adsl out=adsl_sorted; by USUBJID; run;

proc compare base=adsl_sorted compare=adsl_qc listall;
  id USUBJID;
run;