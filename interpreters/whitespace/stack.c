#include "stack.h"

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
stack_add_node_with_value(stack_t * _s, int64_t _v) {
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
stack_print(stack_t * _s) {
  node_t * n = _s->head;

  while(n) {
    printf("%llu, ", n->data);
    n = n->next;
  }
  printf("\n");
}

node_t * 
stack_pop(stack_t * _s) {
  node_t * n = _s->head;

  if (_s->head)
    _s->head = _s->head->next;
  else
    _s->head = NULL;
  
  return n;
}

