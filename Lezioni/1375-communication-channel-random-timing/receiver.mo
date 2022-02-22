
block Receiver


parameter Real T = 2000.0;

InputBoolean datavailable;
InputInteger data;
OutputBoolean readsignal;

Integer x;

algorithm

when initial() then
	x := 0;
	readsignal := false;
	
   elsewhen (sample(0,T) and pre(datavailable)) then

           readsignal := not(pre(readsignal)) ;
           x := pre(data);

end when;


end Receiver;