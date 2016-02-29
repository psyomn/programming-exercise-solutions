#include "soe.h"

int main(int argc, char * argv[]) {
  resultset_t* rs = soe(100);
  print_soe(rs);
  free(rs);
  return 0;
}
