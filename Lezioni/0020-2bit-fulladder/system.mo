class System

    Environment env; // genero un oggetto env, l'environment
    SUV  mysuv; // un SUV, che collega il full adder al resto del sistema
    Monitor m; // il monitor

    equation
        // connetto l'environment con il suv. Il monitor sa tutto
        connect(env.x, mysuv.x);
        connect(env.carry_in, mysuv.carry_in);

        connect(env.x, m.x);
        connect(env.carry_in, m.carry_in);
        connect(mysuv.y, m.y);
        connect(mysuv.carry_out, m.carry_out);

end System;