raw_dm <- data.frame(
  SUBJID = c("1001","1002","1003","1004","1005","1006"),
  SEX    = c("M","F","F","M","M","F"),
  AGE    = c(54,61,47,58,66,52),
  TRT    = c("Drug","Placebo","Drug","Placebo","Drug","Placebo"),
  DOSEDT = c("2026-01-10","2026-01-12","2026-01-15",
             "2026-01-18","2026-01-20","2026-01-22"),
  stringsAsFactors = FALSE
)

adsl_r <- raw_dm
adsl_r$TRTSDT <- as.Date(adsl_r$DOSEDT)
adsl_r$SAFFL  <- ifelse(!is.na(adsl_r$TRTSDT), "Y", "N")

saf <- adsl_r[adsl_r$SAFFL == "Y", ]
table(Sex = saf$SEX, Treatment = saf$TRT)