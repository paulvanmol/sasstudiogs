%let path=c:\workshop\git\sasstudiogs;
filename myreps "&path\xmlfiles\report.xml";
filename mymap "&path\xmlfiles\report.map";
libname myreps xmlv2 xmlmap=mymap;
proc print data=myreps.publication noobs;
run;
