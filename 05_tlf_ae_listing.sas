proc sql;
  create table ae_list as
  select a.USUBJID, s.TRT01P, a.AESEQ, a.AETERM, a.AESEV, a.AESER,
         a.AESTDTC, a.AEENDTC
  from ae a inner join adsl s
    on a.USUBJID = s.USUBJID
  where s.SAFFL = "Y"
  order by a.USUBJID, a.AESEQ;
quit;

title1 "Listing 16.2.7";
title2 "Adverse Events by Subject (Safety Population)";

proc report data=ae_list nowd;
  column USUBJID TRT01P AESEQ AETERM AESEV AESER AESTDTC AEENDTC;
  define USUBJID / order "Subject ID";
  define TRT01P  / "Treatment";
  define AESEQ   / "Seq";
  define AETERM  / "Adverse Event";
  define AESEV   / "Severity";
  define AESER   / "Serious?";
  define AESTDTC / "Start Date";
  define AEENDTC / "End Date";
run;

title;