#include "TM4C123GH6PM.h"
#include <string.h>
void printMsg2p(const int a, const int b, const int c)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "Theta = %d degrees,", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, " x = %d, ", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 	 sprintf(Msg, " y = %d\n", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
	 } 
		 
}

