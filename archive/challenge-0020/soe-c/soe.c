#include <inttypes.h>
#include <stdio.h>
#include <string.h>
#include "soe.h"

static uint8_t
is_divisible(uint64_t, uint64_t);

/** Returns a pointer to an array of all the elements which contain stuff */
resultset_t*
soe(int64_t _upto) {
  uint64_t x = 0, y = 0;
  uint8_t divisible = 0;
  uint64_t max_size = (_upto);
  uint64_t memsize = sizeof(int64_t) * max_size;
  uint64_t* arr = malloc(memsize);
  resultset_t* rs = malloc(sizeof(resultset_t));

  memset(arr, 0, memsize);

  rs->arr = arr;
  rs->size = 0;

  *(rs->arr + rs->size) = 2;
  rs->size += 1;

  *(rs->arr + rs->size) = 3;
  rs->size += 1;

  for(x = 5; x < _upto; x += 2) {
    for (y = 0; y < rs->size; ++y) {
      if (divisible |= is_divisible(x, *(rs->arr + y)))
        break;
    }

    if (!divisible)
      add_prime(rs, x);

    divisible = 0;
  }

  return rs;
}

void
print_soe(resultset_t* t) {
  uint64_t* nav;
  uint64_t size;
  uint64_t x;

  nav = t->arr;
  size = t->size;

  for (x = 0; x < size; ++x) {
    printf("%" PRIu64 ", ", *nav);
    ++nav;
  }

  printf("\n");
}

uint8_t
is_divisible(uint64_t x, uint64_t y) {
  return (x % y) == 0;
}

void
add_prime(resultset_t* _rs, uint64_t _prime) {
  _rs->size += 1;
  *(_rs->size - 1 + _rs->arr) = _prime;
}


