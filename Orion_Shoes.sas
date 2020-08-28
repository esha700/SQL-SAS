libname orion '/global/home/gbc_everma/gbc/shared/BUS_4022/Datasets/Assignment_2/';

proc contents data=orion.shoes;
run;

proc contents data=orion.shoes_eclipse;
run;

proc contents data=orion.shoes_tracker;
run;

data shoes; 
 set orion.shoes;
run;

proc append base=shoes data=orion.shoes_eclipse ;
run;

proc append base=shoes data=orion.shoes_tracker (keep=product_category product_group product_name supplier_country supplier_id) force;
run; 
    

proc print data = shoes;
run;

