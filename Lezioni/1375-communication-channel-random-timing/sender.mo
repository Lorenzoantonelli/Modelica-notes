block Sender

	// voglio un tempo di soggiorno di 10

	parameter Integer N = 2;   // size of Markov chain
	parameter Integer z_0 = 1;  // initial state MC

	parameter Real T = 1;   // time in seconds
	//parameter Real T = 1;   // time in milliseconds

	InputBoolean spaceavailable;
	OutputInteger x;
	OutputBoolean writesignal;

	Integer z;

	// Soujourn time S = T/(1 - p) 
	// Thus: p = 1 - (T/S)

	// time in seconds
	// T = 1, S = 10, thus p = 1 - 1/10 = 9/10
	// Transition Matrix MC

	// time in milliseconds
	// T = 1000, S = 10000, thus p = 1 - 1000/10000 = 9/10


	// time in seconds as well as in milliseconds
	parameter Real A[N, N] =
	[
	0.9, 0.1;
	1.0,  0.0
	];


	algorithm

		when initial() then
			z := z_0;
			x := 0;
			writesignal := false;
		
		elsewhen (sample(0,T) and pre(spaceavailable)) then

			z := pick(myrandom(), pre(z), A);
		
			if (z == 2)
			then
				x := 1 - pre(x);
				writesignal := not(pre(writesignal)); 
			end if;
		
		end when;


end Sender;