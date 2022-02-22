class System

Environment env;
SUV  mysuv;
Monitor m;
Monitor2 m2;

equation

connect(env.a, mysuv.a);
connect(env.b, mysuv.b);
connect(env.carry_in, mysuv.carry_in);

connect(env.a, m.a);
connect(env.b, m.b);
connect(env.carry_in, m.carry_in);
connect(mysuv.y, m.y);
connect(mysuv.carry_out, m.carry_out);
connect(mysuv.carry, m.carry);

connect(env.a, m2.a);
connect(env.b, m2.b);
connect(env.carry_in, m2.carry_in);
connect(mysuv.y, m2.y);
connect(mysuv.carry_out, m2.carry_out);
connect(mysuv.carry, m2.carry);

end System;
