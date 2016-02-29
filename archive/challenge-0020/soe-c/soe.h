#pragma once

#include <sys/queue.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

typedef struct {
  uint64_t* arr;
  uint64_t size;
} resultset_t;

resultset_t* soe(int64_t);

void print_soe(resultset_t*);
void add_prime(resultset_t*, uint64_t);
