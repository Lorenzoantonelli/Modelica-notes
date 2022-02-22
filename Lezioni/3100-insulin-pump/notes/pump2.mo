block Pump


InputReal SugarLevel;        //amount of glucose of the patient
OutputReal InsulinDose;   //amount of insulin to give the patient

Real z, err;

parameter Real T = 1;    
parameter Real a = 0.1;
parameter Real b = 0.0;
parameter Real ref = 70;

equation

err = (SugarLevel - ref);


algorithm

when initial() then

InsulinDose := 0;
z := 0;

elsewhen sample(0, T) then

z := pre(z) + T*err;

InsulinDose :=  if SugarLevel >= 50 then max(0, a*err + b*pre(z)) else 0;


end when;

end Pump;
