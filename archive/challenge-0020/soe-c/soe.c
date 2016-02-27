#include "soe.h"
/** Returns a pointer to an array of all the elements which contain stuff */
resultset_t*
soe(int64_t _upto) {
  int64_t max_size = sqrt(_upto);
  int64_t memsize = sizeof(int64_t) * max_size;
  int64_t* arr = malloc(memsize);
  resultset_t* rs = malloc(sizeof(resultset_t));

  memset(arr, 0, memsize);

  rs->arr = arr;
  rs->size = 0;

  *(rs->arr + rs->size) = 2;
  rs->size += 1;

  *(rs->arr + rs->size) = 3;
  rs->size += 1;



  return rs;
}
