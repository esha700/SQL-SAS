libname orion 
	'/global/home/gbc_everma/gbc/shared/BUS_4022/Datasets/Assignment_2';

data work.split;
	set orion.employee_donations;
	PctLoc=find (Recipients, '%');

	if PctLoc>0 then
		do;
			Charity=substr(Recipients, 1, PctLoc);
			output;
			Charity=substr(Recipients, PctLoc+3);
			output;
		end;
	else
		do;
			Charity=trim(Recipients);
			output;
		end;
run;

title "Charity contributions for each Employee";

proc print data=work.split;
	var Employee_ID Charity;
run;

title;
