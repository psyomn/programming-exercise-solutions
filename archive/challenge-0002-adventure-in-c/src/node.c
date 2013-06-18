#include <stdio.h>
#include <string.h>

#include "static.h"
#include "node.h"
#include "tprint.h"

/**
 * Create the node, and initialize it
 * @return
 *   a node initialized with default values
 */
node_t *
node_create(){
  node_t * n = (node_t *) malloc(sizeof(node_t));
  n->n       = NULL;
  n->s       = NULL;
  n->e       = NULL;
  n->w       = NULL;
 
  n->p       = ' ';
  n->visited = ' ';

  n->m = malloc(ADVENTURE_MSG_MAX * sizeof(uint16_t));
  memset(n->m, 0, ADVENTURE_MSG_MAX);

  return n;
}

/** 
 * Print what the specific node looks like 
 */
void
node_look(node_t * n){
  int i;

  tprint("You can go \n");
  if (!(n->n || n->s || n->e || n->w))
    tprint("nowhere\n");
  
  if (n->n) tprint("  north \n");
  if (n->s) tprint("  south \n");
  if (n->e) tprint("  east \n");
  if (n->w) tprint("  west \n");
  tprint("from here.\n\n");

  /* Print additional messages */
  for (i = 0; i < ADVENTURE_MSG_MAX; ++i){
    switch(n->m[i]){
    case ADVENTURE_MSG_NOSE_BLOOD_SMEAR_ID:
      tprint(ADVENTURE_MSG_NOSE_BLOOD_SMEAR);
      break;
    }
  }
}

int
node_link_n(node_t * n1, node_t * n2){
  if (!(n1 || n2)){
    perror("node linking: null pointer given");
    return -1;
  }
  n1->n = n2;
  n2->s = n1;
  return 0;
}

int
node_link_s(node_t * n1, node_t * n2){
  if (!(n1 || n2)){
    perror("node linking: null pointer given");
    return -1;
  }
  n1->s = n2;
  n2->n = n1;
  return 0;
}

int
node_link_e(node_t * n1, node_t * n2){
  if (!(n1 || n2)){
    perror("node linking: null pointer given");
    return -1;
  }
  n1->e = n2;
  n2->w = n1;
  return 0;
}

int
node_link_w(node_t * n1, node_t * n2){
  if (!(n1 || n2)){
    perror("node linking: null pointer given");
    return -1;
  }
  n1->w = n2; 
  n2->e = n1;
  return 0;
}

/**
 * Leave a message at the current node
 * @param id 
 *   is the id of the message we're going to leave
 */
void
node_add_message(node_t * n, uint16_t id){
  int i; 
  uint8_t found = 0;

  for (i = 0; i < ADVENTURE_MSG_MAX; ++i){
    if (n->m[i] == id){
      i = ADVENTURE_MSG_MAX;
      continue;
    }

    if (!n->m[i]){
      n->m[i] = id;
      found = 1;
      i = ADVENTURE_MSG_MAX;
      continue;
    }
  }

  if (!found){
    perror("Not enough space to add message");
  }
}

