%macro pname;

   data _null_;
      set sashelp.vextfl;
      if (substr(fileref,1,3)='_LN' or substr
         (fileref,1,3)='#LN' or substr(fileref,1,3)='SYS') and
         index(upcase(xpath),'.SAS')>0 then do;
         call symputx('pgmname',xpath,'g');
         stop;
      end;
   run;
%mend pname;

%pname

%put pgmname=&pgmname;