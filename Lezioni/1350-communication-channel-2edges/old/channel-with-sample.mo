

block Channel

parameter Real T = 0.1;

InputBoolean readsignal;  
InputBoolean writesignal;  

InputInteger inputdata;  
OutputInteger outputdata;

OutputBoolean datavailable;  
OutputBoolean spaceavailable;  

parameter Integer N = 10;  // fifo size

Integer fifo[N];  // fifo of input msg
Integer oldest; 
Integer newest; 
Integer fifosize;


algorithm

when initial() then

datavailable := false;
spaceavailable := true;
fifosize := 0;
oldest := 1;   // where to read
newest := 1;   //  where to write
outputdata := 0;
for i in 1:N loop fifo[i] := 0; end for;

elsewhen sample(0, T)  then


if ( (pre(readsignal) == false) and
     (readsignal == true) and
     (pre(writesignal) == false) and
     (writesignal == true)
   )
   and
  (pre(fifosize) < N)
then
    // write
    fifo[newest] := inputdata;
    newest := mod(pre(newest), N) + 1;

    //  read
    outputdata := fifo[pre(oldest)] ;
    oldest := mod(pre(oldest), N) + 1 ;

else  // we can only read, pre(fifosize) == N
    outputdata := fifo[pre(oldest)] ;
    fifosize := pre(fifosize) - 1;
    oldest := mod(pre(oldest), N) + 1;
    spaceavailable := true;
    datavailable := if (fifosize >= 1) then true else false;
end if;

if ( ((pre(readsignal) == false) and (readsignal == true))
     and
     ((pre(writesignal) == true) or (writesignal == false) )
   )
   and
   (pre(fifosize) >= 1)
then  // there is sometghing to read
    outputdata :=  fifo[pre(oldest)] ;
    fifosize := pre(fifosize) - 1;
    spaceavailable := true;
    datavailable := if (fifosize >= 1) then true else false;
    oldest := mod(pre(oldest), N) + 1;
end if;


if ( ((pre(readsignal) == true) or (readsignal == false))
     and
     ((pre(writesignal) == false) and (writesignal == true) )
   )
and
(pre(fifosize) < N)
then  // there is space for writing
    fifo[newest] := inputdata;
    newest := mod(pre(newest), N) + 1;
    fifosize := pre(fifosize) + 1;
    datavailable := true;
    spaceavailable := if (fifosize < N) then true else false;
end if;

end when;


end Channel;