block MarkovChain

	GlobalParameters p;  // p.T smapling time

	parameter Integer N = 8;   // size of Markov chain
	parameter Integer x_0 = 1;  // initial state MC

	parameter Integer NumOfIncrements = 8;   // How many increments are needed to complete the sw development

	OutputInteger x;  // micro delivery state

	OutputInteger y;  // 0 when delivering

	Real v;

	// 1: requirement phase
	// 2: design phase
	// 3: implementation phase
	// 4: unit testing phase
	// 5: integration phase
	// 6: integration testing phase
	// 7: acceptance testing phase
	// 8: delivery

	/*
	Let p the probability of remaining in state x, thus (1-p) is the probability of leaving x.
	Let T the sampling time.
	The expected value for the soujourn time S is:
	S = (1-p)*T + p*(1-p)*2*T + p^2*(1-p)*3*T + p^3*(1-p)*4*T + ... = (1 - p)*T*\sum_{k=1}^{+\ifty} k * p^{k-1}

	Now, we observe that
	W = \sum_{k=0}^{+\ifty} p^{k} = 1/(1 - p)

	Thus,
	d W/d p = 1/(1 - p)^2

	Furthermore,
	d W/d p = \sum_{k=0}^{+\ifty} k * p^{k-1} = \sum_{k=1}^{+\ifty} k * p^{k-1}

	Thus

	S = (1 -p)*T*W = (1 -p)*T*(1/(1-p)^2) = T/(1-p)

	E.g.,
	if we want S to be 10*T then we must chose p = 9/10
	if we want S to be 20*T then we must chose p = 19/20.

	We have 8 iterations. Without reworking we want a delivery after 70 time units.
	Thus, each micro delivery (on average) takes (70/8) time units.
	Each micro delivery consists of 7 steps. Thus each step takes (on average) 70/(7*8) = 10/8 = 5/4 = 1.25 time units.
	To have S = 1.25*T = T/(1 - p). Thus p = 1/5.
	*/


	// 1: requirement phase
	// 2: design phase
	// 3: implementation phase
	// 4: unit testing phase
	// 5: integration phase
	// 6: integration testing phase
	// 7: acceptance testing phase
	// 8: delivery

	// Transition Matrix MC
	parameter Real A[N, N] =
	[
	1.0/5.0, 4.0/5.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;  
	1/10.0, 1.0/5.0, 35/50.0, 0.0, 0.0, 0.0, 0.0, 0.0;
	1.0/20.0, 1.0/20.0, 1.0/5.0, 35/50.0, 0.0, 0.0, 0.0, 0.0;
	1.0/30.0, 1.0/30.0, 1.0/30.0, 1.0/5.0, 35/50.0, 0.0, 0.0, 0.0;
	1.0/40.0, 1.0/40.0, 1.0/40.0, 1.0/40.0, 1.0/5.0, 35/50.0, 0.0, 0.0;
	1.0/50.0, 1.0/50.0, 1.0/50.0, 1.0/50.0, 1.0/50.0, 1.0/5.0, 35/50.0, 0.0;
	1.0/60.0, 1.0/60.0, 1.0/60.0, 1.0/60.0, 1.0/60.0, 1.0/60.0, 1.0/5.0, 35/50.0;
	1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
	];

	// Without reworking delivery time is :: 7*10 = 70

	algorithm

		when initial() then
		x := x_0;
		y := NumOfIncrements;

			
			for i in 1:N loop
		v := 0; for j in 1:N loop v := v + A[i, j]; end for;
			assert(abs(v  - 1.0) <= 1E-6, "Sum of Markov matrix rows is not 1", AssertionLevel.error);
		end for;
		
		elsewhen sample(0, p.T) then

			if (y == 0)
		then  // begin iteation for new delivery
			y := NumOfIncrements;
		end if;

			x := pick(myrandom(), x, A);

			if (x == 8)
		then  // micro-delivery ready
			y := y - 1;
		end if;

			
		
		end when;


end MarkovChain;

