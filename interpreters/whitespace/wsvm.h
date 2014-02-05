#ifndef __WSVM_H__
#define __WSVM_H__

#include "stack.h"

struct wsvm {
  stack_t * stack;
  // heap 
};

void
wsvm_put(int64_t);

int64_t
wsvm_pop();

#endif 

