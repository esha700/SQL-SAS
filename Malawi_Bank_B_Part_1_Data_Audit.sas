options validvarname=v7; 

proc import datafile="/global/home/gbc_everma/My Folder Esha/LOAN_PORTFOLIO.csv"
dbms=csv out=loans  replace;
guessingrows=max;

/* proc contents data=work.loans; */
/* run; */
/*  */
proc print data=work.loans;
run; 

*******************************************
**/Proc Freq For Categorical Variables*/;**
*******************************************;

proc freq data=work.loans;
tables BranchID ProductID Application_Score Actual_Application_Grade Actual_Good_Bad Gender LiteracyLevel 
Occupation MaritalStatus PurposeCode DonorID LoanSeries CreditOfficerID SectorID ArrearsPer;
run;

*************************************
**/Proc Means for Numerical Data/*;**
*************************************;

Proc means data=work.loans;
Var ActualBalance
Application_Score
ArrearsAmount
ArrearsDays
ArrearsPer
Disbursement_Amount
InstallmentAmt;
run;

******************************************
**/Proc Univariate for Numerical Data/*;**
******************************************;

Proc univariate data=work.loans;
 var ActualBalance
  Application_Score
  ArrearsAmount
  ArrearsDays
  ArrearsPer
  Disbursement_Amount
  InstallmentAmt;

run;
