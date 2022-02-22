class System

Monitor1 m1;

MarkovChain mc;

equation

connect(mc.y, m1.x);

end System;
