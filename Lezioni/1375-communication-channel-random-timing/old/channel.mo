
block Channel

parameter Real T = 0.5;  // sending time period

parameter Integer N = 10;  // fifo size

parameter Integer nop = 1;  // nop msg


Integer fifo[N];  // fifo of input msg

Integer counter; // fifo counter
Integer fifostart; // fifo start
Integer fifosize; // fifo end


InputInteger u;  
OutputInteger y;

Boolean z;

initial equation
z = false;
fifostart = 0;
fifosize = 0;
counter = fifostart;


// Detect non nop message

equation
z = not(u == nop) ;


algorithm


//  writing into the fifo
when (edge(z) and (fifosize < N)) then
  z := true;
  fifo[1 + counter] := u;
  counter := mod(counter + 1, N);
  fifosize := fifosize + 1;
end when;


// sending from the fifo
when sample(0, T)  then
  if (fifosize >= 1)
  then 
      y := fifo[mod(counter - fifosize, N) + 1] ;
      counter := mod(counter + 1, N);
      fifosize := fifosize - 1;
  else // (fifosize <= 0)
     y := nop;
  end if;
end when;


end Channel;