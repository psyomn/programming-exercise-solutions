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
  add_node_with_value(s, 1);
  add_node_with_value(s, 2);
  add_node_with_value(s, 3);
  add_node_with_value(s, 4);

  print_stack(s);

  t = pop(s);

  printf("Popped value %d\n", t->data);
  free(t);

  printf("Stack is now ... ");
  print_stack(s);

  return 0;
}

