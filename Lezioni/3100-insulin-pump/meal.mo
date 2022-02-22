block Meal

    parameter Real T = 10;   // time step in minutes
    parameter Real AvgFasting = 360;  // avg time between meals (in minutes)
    parameter Real StdDevFasting = 60;  // StdDev time between meals (in minutes)

    parameter Real Max_MealDuration = 60;  // duration of a meal (in minutes)
    parameter Real MealAvgValue = 1.0;  // Avg Carbohydrates per minute from meal
    parameter Real MealStdDev = 0.3;  // StdDev Carbohydrates per minute from meal


    OutputReal MealDose;

    Real meal_duration, fast_duration;
    Real Max_Fasting;

    Boolean eating;

    algorithm

        when initial() then

            meal_duration  := 0;
            fast_duration := 0;
            eating := false;
            MealDose := 0;
            Max_Fasting := AvgFasting + (1 - 2*myrandom())*StdDevFasting ;

        elsewhen sample(0, T) then


            if not(eating) and  (fast_duration >= Max_Fasting) then

                // begin eating
                eating := true;
                meal_duration := 0;
                MealDose := MealAvgValue + (1 - 2*myrandom())*MealStdDev ;

            elseif not(eating) and  (fast_duration < Max_Fasting) then
                // keep fasting 
                fast_duration := pre(fast_duration) + T;


            elseif eating and (meal_duration < Max_MealDuration) then
                // keep eating
                meal_duration := pre(meal_duration) + T;

            elseif eating and (meal_duration >= Max_MealDuration) then
                // just finished eating

                MealDose := 0;
                meal_duration := 0;
                eating := false;
                fast_duration := 0;
                Max_Fasting := AvgFasting + (1 - 2*myrandom())*StdDevFasting ;

            else  // should never happen
                MealDose := 0;
                eating := false;
                meal_duration := 0;
                fast_duration := 0;

            end if;


        end when;

end Meal;