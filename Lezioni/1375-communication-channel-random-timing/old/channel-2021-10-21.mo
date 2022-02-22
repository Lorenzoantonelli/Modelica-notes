

block Channel

InputBoolean readsignal;  
InputBoolean writesignal;  

InputInteger inputdata;  
OutputInteger outputdata;
//OutputInteger fifosize;

OutputBoolean datavailable;  
OutputBoolean spaceavailable;  

parameter Integer N = 10;  // fifo size

Integer fifo[N];  // fifo of input msg

Integer counter; // fifo counter
Integer fifosize; // fifo end

initial equation
fifosize = 0;

equation

datavailable = (fifosize >= 1);
spaceavailable = (fifosize < N);

algorithm

when initial() then

counter := 0;
outputdata := 0;
for i in 1:N loop fifo[i] := 0; end for;

elsewhen edge(readsignal) then

 if (pre(fifosize) >= 1)
  then
    outputdata := fifo[mod(pre(counter) - pre(fifosize), N) + 1] ;
    fifosize := pre(fifosize) - 1;
  else
    fifosize := pre(fifosize);
  end if;
  
elsewhen edge(writesignal) then

 if (pre(fifosize) < N)
 then
    fifo[1 + pre(counter)] := inputdata;
    counter := mod(pre(counter) + 1, N);
    fifosize := pre(fifosize) + 1;
  else
    fifosize := pre(fifosize);
 end if;

end when;


/*
if ( (pre(fifosize) >= 1) and edge(readsignal) )
  then 
      outputdata := fifo[mod(pre(counter) - pre(fifosize), N) + 1] ;
      fifosize := pre(fifosize) - 1;
  elseif ( (pre(fifosize) < N) and edge(writesignal) )  // check for writings
  then
    fifo[1 + pre(counter)] := inputdata;
    counter := mod(pre(counter) + 1, N);
    fifosize := pre(fifosize) + 1;
  else // nothing to be done
    fifosize := pre(fifosize);
 end if;
*/

// end when;

/*
//fifosize := fifosize;

// check for readings

if ( datavailable  and edge(readsignal) )
  then 
      outputdata := fifo[mod(counter - fifosize, N) + 1] ;
      fifosize := fifosize - 1;
  elseif ( spacevailable  and edge(writesignal) )  // check for writings
  then
    fifo[1 + counter] := inputdata;
    counter := mod(counter + 1, N);
    fifosize := fifosize + 1;
 end if;


end when;
*/




end Channel;