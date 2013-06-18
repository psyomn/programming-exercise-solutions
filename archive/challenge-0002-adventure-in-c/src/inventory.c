#include <stdint.h>
#include <stdlib.h>

#include "static.h"
#include "inventory.h"

/**
 * Allocate memory for an inventory and init.
 * @return
 *   an inventory pointer in memory
 */
inventory_t *
create_inventory(){
  inventory_t * inv = malloc(sizeof(inventory_t));
  inv->bag = malloc(sizeof(uint16_t) * ADVENTURE_MAX_INVENTORY);
  return inv;
}

/**
 * Deallocate memory from the inventory
 * @param inv
 *   a pointer to the inventory
 */
void
destroy_inventory(inventory_t * inv){
  free(inv->bag);
  free(inv);
}

