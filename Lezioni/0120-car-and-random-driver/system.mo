class System

    Car q;
    Driver u;

    equation
    connect(u.throttle, q.throttle);  // driver actuates throttle
    connect(u.brake, q.brake);        // driver actuates brake


end System;
