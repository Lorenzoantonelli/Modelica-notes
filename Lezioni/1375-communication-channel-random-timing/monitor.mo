
block MonitorReq1

/*
Output sequence is equal to input sequence
*/

parameter Integer N = 100;


InputBoolean readsignal;  
InputBoolean writesignal; 
InputInteger inputdata;  
InputInteger outputdata;
InputBoolean datavailable;  
InputBoolean spaceavailable;  


Integer newestinput;
Integer oldestinput;
Integer InputBuffer[N];  

Boolean error;
Boolean readsigint;  
Boolean writesigint;


equation

readsigint = not(pre(readsignal) == readsignal) ;

writesigint = not(pre(writesignal) == writesignal) ;


algorithm


when initial() then
error := false;
newestinput := 0;  // where to write
oldestinput := 0;  // where to read

for i in 1:N loop InputBuffer[i] := 0; end for;


elsewhen (readsigint and writesigint) then
// read an write

if (pre(spaceavailable))
then

// write 
    InputBuffer[pre(newestinput) + 1] := inputdata;
    newestinput := mod(pre(newestinput) + 1, N);

// read    
  error := pre(error) or not(InputBuffer[pre(oldestinput) + 1] == outputdata);
  assert(error == false, "ck100",  AssertionLevel.error);
  oldestinput := mod(pre(oldestinput) + 1, N);

else  // not(pre(spaceavailable)) thus pre(datavailable)

// read
   error := pre(error) or not(InputBuffer[pre(oldestinput) + 1] == outputdata);
   assert(error == false, "ck300",  AssertionLevel.error);
   oldestinput := mod(pre(oldestinput) + 1, N);

// write
    InputBuffer[pre(newestinput) + 1] :=  inputdata;
    newestinput := mod(pre(newestinput) + 1, N);

end if;

elsewhen (readsigint and not(writesigint) and pre(datavailable)) then

// we read

    error := pre(error) or not(InputBuffer[pre(oldestinput) + 1] == outputdata);

   assert(error == false, "ck400",  AssertionLevel.error);

oldestinput := mod(pre(oldestinput) + 1, N);

elsewhen (not(readsigint) and writesigint and pre(spaceavailable)  ) then

// we write

    InputBuffer[pre(newestinput) + 1] :=  inputdata;
    newestinput := mod(pre(newestinput) + 1, N);



end when;


end MonitorReq1;