

block Channel

InputBoolean readsignal;  
InputBoolean writesignal;  

InputInteger inputdata;  
OutputInteger outputdata;
OutputBoolean datavailable;  
OutputBoolean spacevailable;  

parameter Real T = 0.5;  // sending time period

parameter Integer N = 10;  // fifo size

Integer fifo[N];  // fifo of input msg

Integer counter; // fifo counter
Integer fifosize; // fifo end

initial equation
fifosize = 0;

equation

datavailable = (fifosize >= 1);
spacevailable = (fifosize < N);

algorithm

when initial() then

counter := 0;
outputdata := 0;
for i in 1:N loop fifo[i] := 0; end for;

elsewhen ((pre(fifosize) >= 1) and edge(readsignal)) then

//elsewhen (sample(0, T) and edge(readsignal)) then


//if (pre(fifosize) >= 1)            // and edge(readsignal) )
//  then 
      outputdata := fifo[mod(pre(counter) - pre(fifosize), N) + 1] ;
      fifosize := pre(fifosize) - 1;
//  else
//      fifosize := pre(fifosize);
//end if;

elsewhen ((pre(fifosize) < N) and edge(writesignal)) then

//elsewhen (sample(0, T) and (pre(fifosize) < N) and edge(writesignal)) then

    fifo[1 + pre(counter)] := inputdata;
    counter := mod(pre(counter) + 1, N);
    fifosize := pre(fifosize) + 1;

elsewhen sample(0, T)  then

fifosize := pre(fifosize);

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