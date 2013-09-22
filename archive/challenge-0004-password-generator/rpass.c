#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>

int  my_atoi(char *);
char randc(void);
void init(void); 

/** 
 * Random password generator. 
 * 
 * Usage: ./rpass <num-passwords> <length-of-each-password>
 *
 * @author Simon Symeonidis 
 */
int main(int argc, char * argv[]){
  int password_count  = 0;
  int password_length = 0;
  int pc_loop = 0;
  int pl_loop = 0;

  init();

  /* Check to see that we got the correct stuff in */
  if (argc != 3){
    printf("Usage:\n"
           "  rpass <num-passwords> <length-of-each-password>\n"); 
    return -1;
  }

  password_count  = my_atoi(argv[1]);
  password_length = my_atoi(argv[2]);

  for ( ; pc_loop < password_count; ++pc_loop){
    for (pl_loop = 0; pl_loop < password_length; ++pl_loop)
      printf("%c", randc());
    printf("\n");
  }

  return 0; 
}

int my_atoi(char * str){
  int length = strlen(str);
  int number = 0; 
  int i; 

  for (i = 0; i < length; ++i){
    number *= 10;
    number += str[i] - 48;
  }

  return number;
}

/** Essentially we want a number from 33 -> 126 */
char randc(void){
  return (char) (33 + rand() % 93);
}

void init(void){
  srand(time(NULL));
}

