libname orion base
    "/global/home/gbc_everma/gbc/shared/BUS_4022/Datasets/Assignment_2";

/* Question 9a */
data work.sale_stats;
    set orion.orders_midyear;
    MonthAvg=mean(of Month1-Month6);
    MonthMax=max(of Month1-Month6);
    MonthSum=sum(of Month1-Month6);
    format MonthAvg 5.;
run;

title "Statistics on Months in which the Customer Placed an Order";

/* Question 9b */
proc print data=work.sale_stats noobs;
    var Customer_ID MonthAvg MonthMax MonthSum;
run;

title;

/* Question 9c */
data freqcustomers;
    set orion.orders_midyear;
    if nmiss(of Month1-Month6) > 1 then
        delete;
    else
        do;
            Month_Median=mean(of Month1-Month6);
            Month_Highest=max(of Month1-Month6);
            Month_2ndHighest=largest(2, of Month1-Month6);
        end;
run;

/* Question 9d */
title "Statistics on Months having Frequent Customers";

proc print data=freqcustomers noobs;
run;

title;

