class System

Monitor1 m1;

MarkovChain mc(x_0=1);

equation

connect(mc.x, m1.x);

end System;
