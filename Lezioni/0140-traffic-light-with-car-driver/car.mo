
block Car

parameter Real Mass = 1500;  // car weigth in Kilograms

// max acceleration = 10 seconds to go from 0 tp 100Km/h (Ford Mondeo)
// a = velocty/time = 100/(10/3600) = 360*100 = 36000 (Km/h^2) =
// speed in meters per second = 100*1000/3600 = 1000/36 = 27.78 m/s velocity
// accelelration in m/s^2 = 27.78/10 = 2.78 m/s^2  (g = 9.8 m/s^2).

// Breaking: home many meters to go from 100 HM/h to 0: (Frod Mustang) :  34 meters.
// Max deceleration:

parameter Real MaxAcceleration = 36000;  // max possible acceleration in Km/h^2 
parameter Real Friction = 300000;  // 

parameter Real MaxThrottle = Mass*MaxAcceleration;  // max possible force (rough)
parameter Real MaxBreak = 36000;  // max possible force (rough)

InputReal throttle;  // real number on [0, 1] 
InputReal brake;  // real number on [0, 1] 

OutputReal x;  // car position
OutputReal v;  // car velocity


initial equation
x = 0;
v = 0;

equation

//  Throttle = Force = Mass * Accelleration = m * a
//  a = der(velocity) = Force/Mass = throttle/m
//  velocity = der(x)
// considering

der(v) = MaxAcceleration*throttle  - (MaxBreak/Mass)*brake*v - (Friction/Mass)*v;   // MaxThrottle*throttle/M = MaxAcceleration*throttle

der(x) = v;


end Car;