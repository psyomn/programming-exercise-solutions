#include <stdio.h>
#include "soe.h"

int main(int argc, char * argv[]) {
  resultset_t* rs;

  printf("\n");;
  rs = soe(100);
  print_soe(rs);
  free(rs);

  printf("\n");;
  rs = soe(500);
  print_soe(rs);
  free(rs);

  printf("\n");;
  rs = soe(25000);
  print_soe(rs);
  free(rs);

  return 0;
}
