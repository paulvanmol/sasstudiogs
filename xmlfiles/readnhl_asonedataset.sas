/*REading xml as one sas dataset*/
%let path=c:\workshop\git\sasstudiogs;
filename nhl "&path\xmlfiles\nhl.xml"; /*1*/
filename map "&path\xmlfiles\nhl.map"; /*2*/

libname nhl xmlv2 xmlmap=map; /*3*/

proc print data=nhl.teams; /*4*/
run;

/*Using Automap to Generate an XMLMap*/

filename nhl "&path\xmlfiles\nhl.xml"; /**/
filename map "&path\xmlfiles\nhlgenerate.map"; /**/

libname nhl xmlv2 automap=replace xmlmap=map; /**/

proc print data=nhl.team; /**/
run;

proc print data=nhl.conference; 
run;

proc sql; 
create table work.allnhl as 
select * from nhl.division natural join nhl.conference 
natural join nhl.team; 
quit; 
