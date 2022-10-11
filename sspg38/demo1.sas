data fish2;
	set sashelp.fish;
	ratio=Height/ Weight;
run;

proc print data=fish2;
run;