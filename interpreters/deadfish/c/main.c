/* Deadfish esolang
 * Simon Symeonidis 
 *
 * i - increase register
 * d - decrease _
 * s - square   _
 * o - print    _
 */
#include <stdio.h>

int main(int argc, char * argv[]){
  char   container = 0;
  size_t index = 0;

  if (argc < 2) {
    printf("usage: deadfish <(i|s|d|o)+>\n");
    return -1;
  }

  while (0 != argv[1][index]){
    switch(argv[1][index]){ 
    case 'i': ++container; break;
    case 'd': --container; break;
    case 'o': printf("%c", container); break;
    case 's': container = container * container; break;
    }
    ++index;
  }

  return 0;
}

