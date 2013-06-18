#ifndef __INVENTORY_H__
#define __INVENTORY_H__

#include <stdint.h>

struct inventory {
  uint16_t * bag;
};

typedef struct inventory inventory_t;

inventory_t *
create_inventory();

void
destroy_inventory(inventory_t *);

#endif /* inventory.h */

