options nosyntaxcheck nodmssynchk; 
%let START_DTTM=%SYSFUNC(DATETIME(), DATETIME.);; 
%let output_table=orion.job_status; 
%let JOB_NAME=errorhandling;
%let target_table=WORK.CLASS; 
libname orion "d:\workshop\orionstar\orstar";