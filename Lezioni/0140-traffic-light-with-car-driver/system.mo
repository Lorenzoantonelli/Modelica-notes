class System

Car q;
Driver u;
TrafficLight tl;

equation
    connect(u.throttle, q.throttle);  // driver actuates throttle
    connect(u.brake, q.brake);        // driver actuates brake
    connect(tl.x, u.w);   // driver senses traffic light

end System;
