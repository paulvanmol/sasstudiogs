/*Using Syserr to check return codes of SAS Datastep and Proc steps*/
proc means data=sashelp.class;
class sex;
var wieght;
run;



proc means data=sashelp.class;
class sex;
var weight;
run;
