class System

Car q;
Driver u;
TrafficLight tl;
Monitor1 m1;

equation


connect(u.throttle, q.throttle);  // driver actuates throttle
connect(u.brake, q.brake);        // driver actuates brake

connect(tl.x, u.w);   // driver senses traffic light

connect(tl.x, m1.w);   // monitor
connect(q.v, m1.CarSpeed);   // monitor

end System;
