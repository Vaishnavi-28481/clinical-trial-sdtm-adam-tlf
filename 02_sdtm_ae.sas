data raw_ae;
  infile datalines dsd truncover;
  input SUBJID :$4. AETERM :$30. AESTDT :$10. AEENDT :$10. SEV :$8. SER :$1.;
datalines;
1001,Headache,2026-01-15,2026-01-17,MILD,N
1001,Nausea,2026-01-20,2026-01-21,MODERATE,N
1003,Dizziness,2026-01-25,2026-01-28,MILD,N
1004,Rash,2026-01-30,,MODERATE,N
1005,Hypertension,2026-02-02,2026-02-10,SEVERE,Y
1006,Headache,2026-02-03,2026-02-04,MILD,N
;
run;

/* get USUBJID from DM */
proc sql;
  create table ae_pre as
  select a.*, d.USUBJID
  from raw_ae a inner join dm d
    on a.SUBJID = d.SUBJID;
quit;

proc sort data=ae_pre; by USUBJID AESTDT; run;

data ae;
  length STUDYID $8 DOMAIN $2 USUBJID $20 AESEQ 8 AETERM $30
         AESEV $8 AESER $1 AESTDTC $10 AEENDTC $10;
  set ae_pre;
  by USUBJID;
  STUDYID = "ABC123";
  DOMAIN  = "AE";
  if first.USUBJID then AESEQ = 0;
  AESEQ + 1;
  AESEV   = SEV;
  AESER   = SER;
  AESTDTC = AESTDT;
  AEENDTC = AEENDT;
  keep STUDYID DOMAIN USUBJID AESEQ AETERM AESEV AESER AESTDTC AEENDTC;
run;

proc print data=ae; run;

data adsl;
  length STUDYID $8 USUBJID $20 SUBJID $4 SITEID $3 AGE 8 AGEGR1 $5
         SEX $1 RACE $25 TRT01P $10 TRT01PN 8 TRTSDT 8 SAFFL $1;
  set dm;

  AGEGR1  = ifc(AGE < 55, "<55", ">=55");
  TRT01P  = ARM;
  TRT01PN = ifn(ARMCD = "DRUG", 1, 2);
  TRTSDT  = input(RFSTDTC, yymmdd10.);
  format TRTSDT date9.;

  if not missing(TRTSDT) then SAFFL = "Y";
  else SAFFL = "N";

  keep STUDYID USUBJID SUBJID SITEID AGE AGEGR1 SEX RACE
       TRT01P TRT01PN TRTSDT SAFFL;
run;

proc print data=adsl; run;

/* N per treatment group */
proc freq data=adsl;
  tables TRT01P / nocum;
  title "Number of Subjects by Treatment";
run;

/* Age summary by treatment */
proc means data=adsl n mean std min max maxdec=1;
  class TRT01P;
  var AGE;
  title "Age (years) by Treatment";
run;

/* Sex and age group by treatment (counts and column %) */
proc freq data=adsl;
  tables (SEX AGEGR1) * TRT01P / nopercent norow;
  title "Sex and Age Group by Treatment";
run;