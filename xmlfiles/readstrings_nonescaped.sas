libname myfiles xmlv2 'd:\workshop\studiodemo\xmlfiles\strings.xml';

libname myfiles xmlv2 'd:\workshop\studiodemo\xmlfiles\strings.xml' xmlprocess=permit;
proc print data=myfiles.chars;
run;
libname myfiles xmlv2 'd:\workshop\studiodemo\xmlfiles\strings.xml' xmlprocess=permit;
proc print data=myfiles.chars;
run;