#ifndef __EXT_LIB_C
#define __EXT_LIB_C

// Your code goes here
#include <stdlib.h>
#include <stdio.h>
// #include <time.h> // non è necessario mettere questa include

double myrandom()
{
static int i = 0; // static variable, serve per ricordarsi lo stato della funzione. Cosa legale in C, ma non in Modelica.
time_t t; // servirebbe importare time.h, ma in realtà per Modelica non è necessario farlo.

// just for test

  if (i == 0)
    /* first time rand is called  */
    {
      i = 1;
     
      /* Intializes random number generator */
      srand((unsigned) time(&t));
      
    }
		
		
   return (  ((double) rand())/((double) RAND_MAX) );


}  /*  myrandom()  */


#endif
