/* This macro is called from two other macros below. It defines any
   common error handling code, and it should be customized. 

   In some programs, you may want to clean up here.
*/
%macro email_and_abort;
 /* Send an email */
 filename mymail email "paul.van.mol@sas.com" subject="error in SAS program";
 data _null_;
  file mymail;
  put 'Check the SAS logs';
 run; 

 /* Stop further processing */
 %abort cancel;
%mend;

/* This macro asserts the last procedure did not throw an error 
   or a warning. We will invoke this macro after each step. */
%macro expect_no_syserr;
/* If there is an error or warning... */
%if &syserr ne 0 %then %do;
 /* Write the error code to the SAS log */
 %put ERROR: &=syserr;

 %email_and_abort;
 %end;
%mend;


/* Assuming SASHELP.CLASS exists and contains the character 
   variable SEX, this DATA STEP will succeed. */
data female;
 set sashelp.class;
 if sex='F';
run;
%expect_no_syserr;

/* Likewise, the macro works with procedures such as PROC FREQ. */
proc freq data=sashelp.class noprint;
 table age/out=age_freq;
run;
%expect_no_syserr;


/* This macro asserts PROC SQL creates at least one observation. */
%macro expect_any_obs;
%if &sqlobs eq 0 %then %do;
 %put ERROR: no observations;

 %email_and_abort;
 %end;
%mend;

/* This PROC SQL shows that the assertions working with PROC
   SQL and that two assertions can be combined. */
proc sql;
 create table age_count as
 select
  age,
  count(1) as count
 from
  sashelp.class
 group by
  age;
quit;
%expect_no_syserr;
%expect_any_obs;

/* Misspelled data set. This will fail to demonstrate the macros. */
data female;
 set sashelp.clss;
 if sex='F';
run;
%expect_no_syserr;