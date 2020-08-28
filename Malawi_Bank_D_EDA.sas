options validvarname=v7; 

proc import datafile="/global/home/gbc_everma/My Folder Esha/G2_LOAN_PORTFOLIO_Cleaned File.csv"
dbms=csv out=loans3  replace;
guessingrows=max;

Title "Literacy Level that occurs most frequently ";
proc freq data=work.loans3 order=freq;
tables LiteracyLevel; 
run;

proc sgplot data = work.loans3;
vbar LiteracyLevel;
run;

Title "Largest Branch in terms of maximum number of Customers";
proc freq data=work.loans3 order=freq;
tables BranchID; 
run;

proc sgplot data = work.loans3;
vbar BranchID;
run;

Title "Branch that disburses largest average loan";
proc means data =work.loans3 mean;
class BranchID; 
var Disbursement_Amount;
run;


Title "Gender group with higher proportion of bad loans (M for Males, F for Females)";
proc tabulate data =work.loans3 out=loans4;
class Gender;
var Actual_Good_Bad;
where Actual_Good_Bad = 0; 
table (Actual_Good_Bad)*(N), Gender All;
run;


Title "Customer Account ID with highest number of days in arrears";
proc sort data =work.loans3;
by descending ArrearsDays;
run;
proc print data = work.loans3(obs = 1);
id AccountID;
var ArrearsDays;
run;




