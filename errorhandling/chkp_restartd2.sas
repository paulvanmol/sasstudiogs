proc scaproc; 
   record "&path\pf03d2.txt"  attr  opentimes;
run;
libname orion "D:\Workshop\OrionStar\orstar"; 
%let country="DE" "FR" ;
%let gender=F; 
data work.orion_star;
   length customer_id 8 customer_name Customer_Country $ 40
              Customer_Gender $ 8;
   if _n_=1 then 
     do; 
        DECLARE  HASH  myhash(dataset: "orion.customer_dim");
        myhash.DEFINEKEY('Customer_ID');                                                                                                        
        myhash.DEFINEDATA('Customer_name' ,'Customer_Country', 
                          'Customer_Gender');                                                                                                     
        myhash.DEFINEDONE();      
     end;   
 /* Retrieve Lookup value by sequential BASE table processing  */
   set orion.order_fact;                                                                                                                 
	 if myhash.FIND()=0 and
  	    customer_country in (&country) and customer_gender = "&gender"; 
run;
proc summary data=work.orion_star sum mean; 
   class customer_country customer_gender;
   var total_retail_price quantity;
   output out=work.summary 
          sum=trp_sum quant_sum mean=trp_mean  quant_mean; 
run;

proc scaproc;
   write;
run;
