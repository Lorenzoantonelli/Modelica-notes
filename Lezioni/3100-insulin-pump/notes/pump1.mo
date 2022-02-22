
block Pump

parameter Real T = 10;    // sampling time in minutes
parameter Real MinInsulinDose = 0;
parameter Real MaxInsulinDose = 1;


InputReal SugarLevel;
OutputReal InsulinDose;

Real Old_SugarLevel, Old_Old_SugarLevel;
Real Normalizing ;

algorithm

when initial() then

Old_SugarLevel := 100;
Old_Old_SugarLevel := 100;
InsulinDose := 0;
Normalizing := 5.4;

elsewhen sample(0, T) then



if (pre(SugarLevel) <  Old_SugarLevel)  then
// Sugar level falling

InsulinDose := 0;

elseif (abs(pre(SugarLevel) - Old_SugarLevel) < 0.000001)  then
// Sugar level stable

InsulinDose := 0;


elseif ((pre(SugarLevel) - Old_SugarLevel) <
       (Old_SugarLevel - Old_Old_SugarLevel))   then
// Sugar level increasing and rate of increase decreasing

InsulinDose := 0;


elseif  ((pre(SugarLevel) - Old_SugarLevel) >=
       (Old_SugarLevel - Old_Old_SugarLevel))

then
// Sugar level increasing and rate of increase stable or increasing


InsulinDose := max(MinInsulinDose,
                   floor((pre(SugarLevel) - Old_SugarLevel)/Normalizing));


else
	InsulinDose := pre(InsulinDose); 

end if;

Old_Old_SugarLevel := Old_SugarLevel;
Old_SugarLevel := pre(SugarLevel);

end when;


end Pump;