/*Question 3 */
/* Libname is a global statement with orion being libref, and the path needs to be changed before running*/

libname orion "/global/home/gbc_everma/gbc/shared/BUS_4022/Datasets/Assignment_2";

 data work.bigdonations;
 set orion.employee_donations;
 Total = sum(Qtr1, Qtr2, Qtr3, Qtr4); 
 NoDonation = nmiss(of Qtr1-Qtr4);
    format Total comma3. NoDonation comma3.;
    if Total < 50 then delete;
    if NoDonation > 0 then delete;
 run; 

/*3.1 e proc print for the report */

proc print data = work.bigdonations;
    var Employee_ID Qtr1 Qtr2 Qtr3 Qtr4 Total NoDonation;
run;
