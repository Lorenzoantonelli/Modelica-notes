
block Queue

parameter Real T = 0.1;

// read side
InputBoolean readsignal;
OutputInteger outputdata;
OutputBoolean datavailable;  

// write side
InputBoolean writesignal;  
InputInteger inputdata; 
OutputBoolean spaceavailable;  

parameter Integer N = 100;  // fifo size

Integer fifo[N];  // fifo of input msg
Integer oldest; 
Integer newest; 
Integer fifosize;

Boolean readsigint;  
Boolean writesigint;

equation

readsigint = not(pre(readsignal) == readsignal) ;
writesigint = not(pre(writesignal) == writesignal) ;


algorithm

when initial() then

datavailable := false;
spaceavailable := true;
fifosize := 0;
oldest := 1;   // where to read
newest := 1;   //  where to write
outputdata := 0;
for i in 1:N loop fifo[i] := 0; end for;


elsewhen (readsigint and writesigint ) then

//assert(false, "channel: Simultaneous read and write", AssertionLevel.warning);


if (pre(fifosize) < N)
 then
    // write
    fifo[pre(newest)] := inputdata;
    newest := mod(pre(newest), N) + 1; // mod(pre(newest) + 1 - 1, N) + 1

    //  read
    outputdata := fifo[pre(oldest)] ;
    oldest := mod(pre(oldest), N) + 1 ;

else  // pre(fifosize) >= N
//  read
       outputdata := fifo[pre(oldest)] ;
       oldest := mod(pre(oldest), N) + 1;
  
// write
    fifo[pre(newest)] := inputdata;
    newest := mod(pre(newest), N) + 1; // mod(pre(newest) + 1 - 1, N) + 1

end if;


elsewhen (readsigint and not(writesigint) and  (pre(fifosize) >= 1) ) then


// there is something to read

//assert(false, "channel: Just read", AssertionLevel.warning);

    outputdata :=  fifo[pre(oldest)] ;
 
    fifosize := pre(fifosize) - 1;
    spaceavailable := true;
    datavailable := if (fifosize >= 1) then true else false;
    oldest := mod(pre(oldest), N) + 1;

elsewhen (not(readsigint) and writesigint and  (pre(fifosize) < N)  ) then
	  
//assert(false, "channel: Just write", AssertionLevel.warning);


// there is space for writing
  
    fifo[pre(newest)] := inputdata;
    newest := mod(pre(newest), N) + 1;
    fifosize := pre(fifosize) + 1;
    datavailable := true;
    spaceavailable := if (fifosize < N) then true else false;
    outputdata :=  fifo[pre(oldest)] ;
   
end when;


end Queue;