/* Stream powerpoint output directly to the user's browser. */

ods graphics on / border=off;
filename _dataout "&Folder/SGPlot.pptx";

ods powerpoint file=_dataout;
title 'PROC SGRENDER';
footnote 'ODS Destination for PowerPoint';

title 'Horsepower by Type and Origin';
proc sgplot data=sashelp.cars;
  dot type / response=horsepower limits=both stat=mean
      markerattrs=(symbol=circlefilled size=9);
  xaxis grid;
  yaxis display=(nolabel) offsetmin=0.1;
  keylegend / location=inside position=topright across=1;
  run;

ods powerpoint close;

%let _DATAOUT_MIME_TYPE=application/vnd.openxmlformats-officedocument.presentationml.presentation;
%let _DATAOUT_NAME=sgplot.pptx;
