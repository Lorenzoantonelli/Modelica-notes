function myrandom
  //input Integer seed;
  output Real result;

  external "C" result = myrandom(); // sfrutto quindi la funzione myrandom() definita in C
    annotation(Include = "#include \"myextlib.c\"");


end myrandom;