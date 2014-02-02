/*
** Whitespace implementation
** Simon Symeonidis, Jan 31 2014
*/

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#define WLANG_SPACE   32
#define WLANG_TAB      9
#define WLANG_NEWLINE 10

struct node {
  int64_t data;
  struct node * next;
};

typedef struct node node_t;

struct stack {
  node_t * head;
};

typedef struct stack stack_t;

/* Create a stack, with no elements */
stack_t * 
create_stack() {
  return malloc(sizeof(stack_t));
}

/* Make a node */
node_t * 
create_node() {
  node_t * node = malloc(sizeof(node_t));
  node->data = 0;
  node->next = NULL;
  return node;
}

void 
add_node(node_t * _n, stack_t * _s) {
  _n->next = _s->head;
  _s->head = _n;
}

void 
add_node_with_value(stack_t * _s, int64_t _v) {
  node_t * n = create_node(); 
  n->data = _v;
  add_node(n, _s);
}

size_t 
stack_size(stack_t * _s) {
  node_t * n = _s->head;
  size_t ret = 0; 

  while (n) {
    ++ret;
    n = n->next;
  }

  return ret;
}

void
print_stack(stack_t * _s) {
  node_t * n = _s->head;

  while(n) {
    printf("%d, ", n->data);
    n = n->next;
  }
  printf("\n");
}

node_t * 
pop(stack_t * _s) {
  node_t * n = _s->head;

  if (_s->head)
    _s->head = _s->head->next;
  else
    _s->head = NULL;
  
  return n;
}

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

