#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "tprint.h"

void
tprint(char * s){
  int i; 

  setvbuf(stdout, NULL, _IONBF, 0);
  for (i = 0; i < strlen(s); ++i){
    printf("%c", s[i]);
    usleep(15000);
  }
  setvbuf(stdout, NULL, _IOFBF, 0);
}

