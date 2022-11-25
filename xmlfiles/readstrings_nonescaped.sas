%let path=c:\workshop\git\sasstudiogs; 
libname myfiles xmlv2 "&path\xmlfiles\strings.xml";

libname myfiles xmlv2 "&path\xmlfiles\strings.xml" xmlprocess=permit;
proc print data=myfiles.chars;
run;
libname myfiles xmlv2 "&path\xmlfiles\strings.xml" xmlprocess=permit;
proc print data=myfiles.chars;
run;
