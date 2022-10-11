/*REading xml as one sas dataset*/

filename nhl 'd:\workshop\studiodemo\xmlfiles\nhl.xml'; /*1*/
filename map 'd:\workshop\studiodemo\xmlfiles\nhl.map'; /*2*/

libname nhl xmlv2 xmlmap=map; /*3*/

proc print data=nhl.teams; /*4*/
run;