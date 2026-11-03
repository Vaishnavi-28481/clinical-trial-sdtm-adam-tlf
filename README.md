# Clinical Trial Data Programming: SDTM, ADaM and TLF

Mini practice project using SAS and R on mock clinical trial data (6 subjects).
All data is simulated. No real patient data is used.

## What it covers
- SDTM: DM (Demographics) and AE (Adverse Events) domains
- ADaM: ADSL (subject-level dataset) with age group, treatment, treatment start date and safety flag
- TLF: Table 14.1.1 (demographics by treatment) and Listing 16.2.7 (adverse events)
- QC: independent recreation of ADSL using PROC SQL with PROC COMPARE (no differences found), and of the sex table in R (matched SAS)

## Tools
SAS (SAS OnDemand for Academics), R

## Files
Programs are numbered in the order they should be run:
01_sdtm_dm.sas, 02_sdtm_ae.sas, 03_adam_adsl.sas, 04_tlf_demog_table.sas, 05_tlf_ae_listing.sas, 06_qc_proc_compare.sas, 07_qc_r_validation.R
