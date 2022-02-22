#ifndef __EXT_LIB_C // per evitare che possa essere incluso più volte
#define __EXT_LIB_C

// Your code goes here
#include<stdlib.h>
#include<stdio.h>
#include<time.h>

double myrandom()
{
static int i = 0;
time_t t;

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
