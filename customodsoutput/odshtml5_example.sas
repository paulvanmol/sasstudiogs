filename odsout "d:/workshop/studiodemo/output"; 
ods _all_ close; 
ods graphics /imagemap imagename="cars_originanalysis" height=12cm;
ods html5  path=odsout file="cars_originanalysis.html" gpath=odsout style=illuminate image_dpi=200; 
proc freq data=sashelp.cars;
	table origin /plots=all ; 
	run;


proc means data=sashelp.cars;
	class origin;
	var mpg_city;
run;
/*--Bar Panel--*/

title 'Mileage by Origin and Type';
proc sgpanel data=sashelp.cars(where=(type in ('Sedan' 'Sports'))) noautolegend;
  panelby Type / novarname columns=2 onepanel;
  vbar origin / response=mpg_city stat=mean group=origin;
  rowaxis grid;
  run;
/*--VBox Plot--*/

title 'Mileage by Type and Origin';
proc sgplot data=sashelp.cars(where=(type in ('Sedan' 'Sports'))) ;
  vbox mpg_city / category=origin group=type groupdisplay=cluster
    lineattrs=(pattern=solid) whiskerattrs=(pattern=solid);
  xaxis display=(nolabel);
  yaxis grid;
  keylegend / location=inside position=topright across=1;
  run;
ods html5 close; 
