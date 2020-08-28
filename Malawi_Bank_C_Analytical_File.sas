options validvarname=v7; 

proc import datafile="/global/home/gbc_everma/My Folder Esha/G2_LOAN_PORTFOLIO_Cleaned File.csv"
dbms=csv out=loans2  replace;
guessingrows=max;

data work.recode_derive_var;
set work.loans2;

/* Recoding variables*/

/* Recoding Branch ID to BranchName*/
select;
  length BranchName    $20;
  when (BranchID = 2) BranchName ='Mandala';
  when (BranchID = 3) BranchName ='Kawale';
  when (BranchID = 4) BranchName ='Mzuzu'; 
  when (BranchID = 5) BranchName ='Blantrye'; 
  when (BranchID = 6) BranchName ='Salima';
  when (BranchID = 7) BranchName ='Mchinji';
otherwise; end;
    	
 /* Recoding Product ID to Loan_Type*/ 	
select;  
length Loan_Type    $20;
   when (ProductID = 'LN01') Loan_Type ='Group Business Loan';
   when (ProductID = 'LN02') Loan_Type ='Individual Business Loan'; 
   when (ProductID = 'LN03') Loan_Type ='Share Loan';
   when (ProductID = 'LN04') Loan_Type ='Emergency Loan';
   when (ProductID = 'LN05') Loan_Type ='Share Loan'; 
   when (ProductID = 'LN06') Loan_Type ="Woman's Loan"; 
   when (ProductID = 'LN08') Loan_Type ='Payroll Secured Loan'; 
otherwise; end;

 /* Recoding Actual_Application_Grade to Application_Grade*/ 	
select;
length Application_Grade    $20;
 when (Actual_Application_Grade = 'A') Application_Grade ='High Quality';
 when (Actual_Application_Grade = 'B') Application_Grade ='Good Quality';
 when (Actual_Application_Grade = 'C') Application_Grade ='Fair Quality';
 when (Actual_Application_Grade = 'D') Application_Grade ='Poor Quality'; 
otherwise; end;

/* Recoding Literacy Level to Education Level*/ 	
select;
    length EducationLevel    $20;
    when (LiteracyLevel = 'C') EducationLevel ='College';
    when (LiteracyLevel = 'E') EducationLevel ='Elementary'; 
    when (LiteracyLevel = 'N') EducationLevel ='No Formal Education';
    when (LiteracyLevel = 'P') EducationLevel ='Primary'; 
    when (LiteracyLevel = 'Z') EducationLevel ='Polytechnic'; 
    when (LiteracyLevel = 'S') EducationLevel ='Secondary'; 
    when (LiteracyLevel = 'T') EducationLevel ='Tertiary';
    when (LiteracyLevel = 'U') EducationLevel ='University';
    when (LiteracyLevel = 'X') EducationLevel ='Not Specified';
    otherwise;    end;
    
/* Recoding Actual_Good_Bad to Rating*/ 	
select;
    when (Actual_Good_Bad = 1) Rating ='Good';
    when (Actual_Good_Bad = 0) Rating ='Bad';
otherwise; end;

/* Recoding Occupation to Profession */ 
select;
length Profession    $20;
    when (Occupation = 'P') Profession ='Priest';
    when (Occupation = 'O') Profession ='Professor';
    when (Occupation = 'B') Profession ='Business People';
    when (Occupation = 'C') Profession ='Civil Servants';
    when (Occupation = 'E') Profession ='Employee';
    when (Occupation = 'F') Profession ='Farmer';
    when (Occupation = 'M') Profession ='Self Employed';
    when (Occupation = 'N') Profession ='Unemployed';
    when (Occupation = 'O') Profession ='Other';
    when (Occupation = 'T') Profession ='Traders';
    when (Occupation = 'U') Profession ='Not Specified';
    otherwise;    end;

/* Recoding Marital Status to Marital_Status */ 	
select;
length Marital_Status    $20;
    when (MaritalStatus = 'D') Marital_Status ='Divorced';
    when (MaritalStatus = 'G') Marital_Status ='Group';
    when (MaritalStatus = 'M') Marital_Status ='Married';
    when (MaritalStatus = 'S') Marital_Status ='Single';
    when (MaritalStatus = 'U') Marital_Status ='Not Specified';
    when (MaritalStatus = 'W') Marital_Status ='Widow';
    when (MaritalStatus = 'R') Marital_Status ='Widower';
otherwise;    end;

/* Recoding Purpose Code to Purpose */ 	
select;
length Purpose    $20;
    when (PurposeCode = 1) Purpose ='Expanding Business';
    when (PurposeCode = 2) Purpose ='Land Purchase';
    when (PurposeCode = 3) Purpose ='House Construction';
    when (PurposeCode = 4) Purpose ='Buying a Car';
    when (PurposeCode = 5) Purpose ='Business';
    when (PurposeCode = 6) Purpose ='School Fees';
    when (PurposeCode = 7) Purpose ='Buying a House';
    when (PurposeCode = 8) Purpose ='Paying School Fees';
    when (PurposeCode = 9) Purpose ='Paying Medical Bills';
    when (PurposeCode = 10) Purpose ='Building House';
    when (PurposeCode = 11) Purpose ='Buying Farm Inputs';
    when (PurposeCode = 12) Purpose ='Purchase of Household Items';
    when (PurposeCode = 13) Purpose ='Other Purpose';
    otherwise; end;

/* Code for getting derived variables */

/* 1st Derived Variable: Days on File */
 Duration = yrdif(DisbursedOn, '31Jul2012'd);
   Days_On_File = Duration * 365.25;
   format Days_On_File 5.0;
   
/* 2nd Derived Variable: Credit Grade */
   
   If Application_Score > 40 then Credit_Score ='A';
      Else if 30 < Application_Score <= 40 then do;
      Credit_Score ='B'; end;
      Else if 20 < Application_Score <= 30 then do;
      Credit_Score ='C'; end;
      Else if Application_Score < 20 then do;
      Credit_Score = 'D'; end;

/* 3rd Derived Variable: Portfolio at risk (PAR)*/
/* PAR attemots to measure risk in portfolio by using past as well as future data*/
/* Objective is to answer if all delinquent borrowers default, how much money will the bank stand to lose?*/

Portfolio_at_Risk = ArrearsAmount / Disbursement_Amount;
format Portfolio_at_Risk 5.2; 

/* 4th Derived Variable : Arrears Rate */ 
/* It estimates how much of the total outstanding portfolio is overdue or in arrears*/

Arrears_Rate = ArrearsAmount / ActualBalance;
format Arrears_Rate 5.2;

 
/* 5th Derived Variable: Cumulative Repayment Rate */
/* It helps get a sense of a repayment performance over a long period of time */ 

Cumulative_Repay_Rate = (Disbursement_Amount - ActualBalance) / ActualBalance;
format Cumulative_Repay_Rate 5.2; 

 
run; 
    
Title "Raw Variables and Recoded Raw Variables for ease of data insights";
proc print data=work.recode_derive_var;
var AccountID  BranchName EducationLevel Profession Marital_Status Purpose Loan_Type Application_Grade
Rating Application_Score DisbursedOn ArrearsDays LoanSeries CreditOfficerID Disbursement_Amount InstallmentAmt ActualBalance ArrearsAmount;
run;

Title "Derived Variables";
proc print data=work.recode_derive_var;
var AccountID Days_On_File Credit_Score  Portfolio_at_Risk Arrears_Rate Cumulative_Repay_Rate;
run;  

proc export data=WORK.RECODE_DERIVE_VAR
outfile='/global/home/gbc_everma/My Folder Esha/Assignment 3'
replace;
run;


