
/*Using Syserr to check return codes of SAS Datastep and Proc steps*/
proc means data=sashelp.class;
class sex;
var wieght;
run;

%put &syserr;
%put &syserrortext; 

proc means data=sashelp.class;
class sex;
var weight;
run;

%put &syserr;