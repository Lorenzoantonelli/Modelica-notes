block Patient


    parameter Real Food2Sugar = 5;  
    parameter Real Insulin2SugarExt = 1.0; 
    //parameter Real GSetpoint = 80;  // mg/dL, healthy
    //parameter Real BodyRegulation = 0.1;  // healthy
    //parameter Real BodyRegulation = 0.01;  // unhealthy
    parameter Real BodyRegulation = 0.001;  // deadly
    parameter Real GSetpoint = 150;  // mg/dL, deadly

    InputReal MealDose;
    InputReal InsulinDose;
    OutputReal SugarLevel;

    Real EndogenInsulin;

    initial equation

        SugarLevel = 80;

    equation

        EndogenInsulin = BodyRegulation*(SugarLevel - GSetpoint);

        der(SugarLevel) =  - EndogenInsulin
                        + Food2Sugar*MealDose
                - Insulin2SugarExt*InsulinDose ;


end Patient;