#ifndef __STACK_H__
#define __STACK_H__

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

struct node {
  int64_t data;
  struct node * next;
};

typedef struct node node_t;

struct stack {
  node_t * head;
};

typedef struct stack stack_t;

stack_t * 
create_stack();

node_t * 
create_node();

void 
stack_add_node(node_t *, stack_t *);

void 
stack_add_node_with_value(stack_t *, int64_t);

size_t 
stack_stack_size(stack_t *);

void
stack_print(stack_t *);

node_t * 
stack_pop(stack_t *);

#endif /* end stack_h */

