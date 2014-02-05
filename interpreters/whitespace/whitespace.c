/*
** Whitespace implementation
** Simon Symeonidis, Jan 31 2014
*/

#include <stdio.h>

#include "stack.h"

#define WLANG_SPACE   32
#define WLANG_TAB      9
#define WLANG_NEWLINE 10

int main(int argc, char ** argv) {
  stack_t * s = create_stack();
  node_t * t;
  stack_add_node_with_value(s, 1);
  stack_add_node_with_value(s, 2);
  stack_add_node_with_value(s, 3);
  stack_add_node_with_value(s, 4);

  stack_print(s);

  t = stack_pop(s);

  printf("Popped value %d\n", t->data);
  free(t);

  printf("Stack is now ... ");
  stack_print(s);

  return 0;
}

