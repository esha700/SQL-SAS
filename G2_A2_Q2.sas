/* Libname is a global statement with mylib being libref, and the path needs to be changed before running*/

libname mylib "/global/home/gbc_everma/gbc/shared/BUS_4022/Datasets/Assignment_2";

/* 2.1 Sorting the orion.sales dataset alphabetically by country, and then in descending order by
salary */

proc sort data=mylib.sales out=OrionSales;
    by Country descending Salary;
run;

/*2.2 Using the above sorted file to print results showing only Country, Job_Title,Salary and Last_Name*/

title "Employees sorted country wise with salary in descending order";
proc print data = OrionSales noobs;
    var Country Job_Title Salary Last_Name;
run;
