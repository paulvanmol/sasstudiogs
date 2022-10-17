%let path=d:\workshop\pfndce; 
options dlcreatedir;
libname chkpnt "&path"; 
 
proc scaproc; 
   record "&path\pf03d1.txt" ;
run;
 
data a;
   do i=1 to 10000;
      randomized=uniform(0);
	  output;
   end;
run;

proc scaproc;
  write;
run;
