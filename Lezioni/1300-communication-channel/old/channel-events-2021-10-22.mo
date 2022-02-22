

block Channel

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

initial equation
fifosize = 0;



equation

datavailable = (fifosize >= 1);
spaceavailable = (fifosize < N);

algorithm

when initial() then

oldest := 1;   // where to read
newest := 1;   //  where to write
outputdata := 0;
for i in 1:N loop fifo[i] := 0; end for;

elsewhen (edge(readsignal) and edge(writesignal) ) then

assert(edge(readsignal) and edge(writesignal), "edge(readsignal) and edge(writesignal) ck1", AssertionLevel.warning);

 if (pre(fifosize) < N)
 then
    assert(newest > 0, "newest <= 0, ck61", AssertionLevel.warning);
    // read
    fifo[newest] := inputdata;
    newest := mod(pre(newest), N) + 1;
    // oldest := if (pre(oldest) == 0) then 1 else pre(oldest) ;
    assert(pre(oldest) > 0, "pre(oldest) <= 0, ck7", AssertionLevel.warning);
   //  write
    outputdata := fifo[pre(oldest)] ;
    oldest := mod(pre(oldest), N) + 1 ;
    fifosize := pre(fifosize); 
  else  // we can only read, pre(fifosize) >= N
    assert(pre(oldest) > 0, "pre(oldest) <= 0, ck1777", AssertionLevel.error);
    outputdata := fifo[pre(oldest)] ;
    fifosize := pre(fifosize) - 1;
    oldest := mod(pre(oldest), N) + 1;
  end if;


elsewhen (edge(readsignal) and not(edge(writesignal)) ) then

assert(edge(readsignal) and not(edge(writesignal)), "edge(readsignal) and not(edge(writesignal)) ck102", AssertionLevel.warning);

 
  if (pre(fifosize) >= 1)
  then
    assert(pre(oldest) > 0, "pre(oldest) <= 0, ck1051", AssertionLevel.error);
    outputdata := fifo[pre(oldest)] ;
    fifosize := pre(fifosize) - 1;
    oldest := mod(pre(oldest), N) + 1;
  else
    fifosize := pre(fifosize); 
  end if;


elsewhen (not(edge(readsignal)) and edge(writesignal) ) then

assert(not(edge(readsignal)) and edge(writesignal), "not(edge(readsignal)) and edge(writesignal) ck203", AssertionLevel.warning);

 
 if (pre(fifosize) < N)
 then
    assert(newest > 0, "newest <= 0, ck2061", AssertionLevel.error);
    fifo[newest] := inputdata;
    newest := mod(pre(newest), N) + 1;
    fifosize := pre(fifosize) + 1;
  else
    fifosize := pre(fifosize); 
 end if;


end when;


/*


elsewhen edge(writesignal) then

 if (pre(fifosize) < N)
 then
    newest := mod(pre(newest), N) + 1;
    assert(newest > 0, "newest > 0", AssertionLevel.error);
    fifo[newest] := inputdata;
    fifosize := pre(fifosize) + 1;
    if (pre(oldest) == 0) then oldest := 1; end if;
  else  // pre(fifosize) >= N, no space left for insertion
    fifosize := pre(fifosize);
 end if;


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