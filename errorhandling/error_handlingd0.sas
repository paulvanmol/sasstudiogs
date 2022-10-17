*OPTIONS ERRORABEND;
OPTIONS NOERRORABEND;

/* Misspelled data set */
data female;
 set sashelp.clss;
 if sex='F';
run;


/*Syntax Check Mode*/

proc options option=syntaxcheck; 
proc options option=dmssynchk; 
run; 

options syntaxcheck dmssynchk; 

/* Misspelled data set */
data female;
 set sashelp.clss;
 if sex='F';
run;

proc print data=female; 
run; 

/*Checkpoint Mode and Restart Mode*/
