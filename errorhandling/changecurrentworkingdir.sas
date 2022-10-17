data _null_;
  rc=dlgcdir("d:\workshop\pfndce");
  put rc=;
run; 

data _null_;
  rc=dlgcdir('%userprofile%');
  put rc=;
run;

