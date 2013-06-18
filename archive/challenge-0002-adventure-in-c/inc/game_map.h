#ifndef __GAME_MAP_H__
#define __GAME_MAP_H__

#include <stdint.h>
#include "node.h"

struct game_map {
  uint16_t  width;
  uint16_t  height;
  node_t ** data;
};

typedef struct 
game_map game_map_t;

game_map_t *
game_map_create();

void
game_map_free(game_map_t *);

void
game_map_randomize(game_map_t *, uint8_t);

void
game_map_print(game_map_t *);

#endif /* Game Map */

