/*Interactive Mode*/
proc sql feedback; 
select * from sashelp.class;
create table work.class as 
select CLASS.Name, CLASS.Sex, CLASS.Age, CLASS.Height, CLASS.Weight from sashelp.class
where sex="M"; 
quit; 