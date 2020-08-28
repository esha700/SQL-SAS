libname orion '/global/home/gbc_everma/gbc/shared/BUS_4022/Datasets/Assignment_2';


proc sort data=orion.shoes_eclipse out=work.eclipsesort;
	by Product_Name;
run;

proc sort data=orion.shoes_tracker out=work.trackersort;
	by Product_Name;
run;

data work.e_t_shoes; /* Interleaving the Data Sets*/
set work.eclipsesort work.trackersort;
by Product_Name;
run;


proc print data = work.e_t_shoes;
var Product_Group Product_Name Supplier_ID;
run;


