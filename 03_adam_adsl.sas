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