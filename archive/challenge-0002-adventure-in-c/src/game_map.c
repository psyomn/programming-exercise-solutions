#include <stdio.h>

#include "node.h"
#include "game_map.h"
#include "game_controller.h"

/* create a game map */
game_map_t *
game_map_create(){
  int i, j;
  game_map_t * map;
  map = (game_map_t *) malloc(sizeof(game_map_t));

  map->width  = 10;
  map->height = 10;

  map->data = (node_t **) malloc(sizeof(node_t) * map->height);

  for (i = 0; i < map->height; ++i){
    map->data[i] = (node_t *) malloc(sizeof(node_t) * map->width);
    for (j = 0; j < map->width; ++j){
      map->data[i][j] = * node_create();
    }
  }

  return map;
}

/* Free the memory */
void
game_map_free(game_map_t * map){

}

/* Do not copy the map, alter it in memory */
void
game_map_randomize(game_map_t * map, uint8_t algorithm){
  uint16_t x, y; 
  int i = 10;

  /* Center can be connected anyhow. */
  while(--i)
  for (y = 0; y < map->height; ++y){
  for (x = 0; x < map->width ; ++x){
      switch(rand() % 4){
      case 0:
        if (y > 0) 
          node_link_n(&map->data[x][y], &map->data[x][y-1]);
        break;
      case 1:
        if (y + 1 < map->height)
          node_link_s(&map->data[x][y], &map->data[x][y+1]);
        break;
      case 2:
        if (x + 1 < map->width) 
          node_link_e(&map->data[x][y], &map->data[x+1][y]);
        break;
      case 3:
        if (x > 0) 
          node_link_w(&map->data[x][y], &map->data[x-1][y]);
        break;
      }
    }
  }

  /* Now set the goal */
  map->data
    [rand() % map->width]
    [rand() % map->height].goal = 2;
}

/** 
 * Print the map
 * @param map
 *   is the map to print
 */ 
void
game_map_print(game_map_t * map){
  int i, j;

  for (i = 0; i < map->height; ++i){
  for (j = 0; j < map->width; ++j) {
      printf("%c ", 
      map->data[j][i].p == ' ' ? 
      map->data[j][i].visited :
      map->data[j][i].p);
    }
    printf("\n");
  }
  printf("\n");
}

