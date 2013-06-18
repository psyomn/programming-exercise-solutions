#ifndef __NODE_H__
#define __NODE_H__

#include <stdlib.h>
#include <stdint.h>

struct node {
  struct node * n;
  struct node * s;
  struct node * w;
  struct node * e;

  uint16_t * m;

  char visited;
  char p;          /* For printing */ 
};

typedef struct node node_t;

node_t *
node_create();

int
node_link_n(node_t *, node_t *);

int
node_link_s(node_t *, node_t *);

int
node_link_w(node_t *, node_t *);

int
node_link_e(node_t *, node_t *);

void
node_look(node_t *);

void
node_add_message(node_t *, uint16_t);

#endif /* Node */

