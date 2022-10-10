
proc freq data=sashelp.cars;
	table origin /plots=all ; 
	run;


proc means data=sashelp.cars;
	class origin;
	var mpg_city;
run;