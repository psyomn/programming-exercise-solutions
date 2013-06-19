#ifndef __BIOLOGICAL_H__
#define __BIOLOGICAL_H__

#include <stdint.h>

struct biological {
  uint16_t hitpoints;
  uint16_t attack;
};

typedef struct 
biological biological_t;

biological_t *
biological_create();

void
biological_destroy(biological_t *);

int 
biological_is_dead(biological_t *);

uint16_t 
biological_attack(biological_t *);

void
biological_receive_damage(biological_t *, uint16_t);

void
biological_print(biological_t *);

#endif /* __BIOLOGICAL_H__ */ 

