data add;
input X1 X2 X3 X4 X5 X6 X7 X8 X9 X11 X12 X13 X14 X15 X16 X18 X19 X20 X21 X22 X23 X24 X25 X26 X27 X28 X29 X30 Y;
datalines;
xxxx
run;
libname SQL_MY PCFILES SERVER = '10.0.1.5' PORT='8888' DSN=mysqlserver USER=sauser PASSWORD=Whatever1!2@ SCHEMA=dbo ;
data test;												
set sql_my.Variabledata;
run;
proc append base=test data=add;
run; 
ods output parameterestimates=pe;
proc reg data=test ;
model Y = X1 X2 X3 X4 X5 X6 X7 X8 X9 X11 X12 X13 X14 X15 X16 X18 X19 X20 X21 X22 X23 X24 X25 X26 X27 X28 X29 X30;
output out=Predict(where=(Y=.)) p=predicted stdi=STDI_Pred stdp=STDP_Pred;
run;
proc print data=pe label; 
      id variable;
      format StdErr 21.20
      		 probt    pvalue12.10; 
      var _numeric_;
      title "Parameter Estimates";
      run;