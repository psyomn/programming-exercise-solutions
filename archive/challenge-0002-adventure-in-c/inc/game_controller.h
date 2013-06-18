#ifndef __GAME_CONTROLLER_H__
#define __GAME_CONTROLLER_H__

#include <stdint.h>

#include "game_map.h"
#include "biological.h"

struct game_session {
  game_map_t   * map;
  biological_t * player;
  uint16_t player_position_x;
  uint16_t player_position_y;
}; 

typedef struct 
game_session game_session_t;

game_session_t *
create_game_session();

void
game_controller_init();

void
game_controller_start();

void
game_controller_battle();

void
game_controller_new_session();

int
game_controller_can_move(game_session_t *, char);

void
game_controller_move_player(game_session_t *, uint16_t);

void
game_controller_look(game_session_t *);

int
game_controller_reached_goal(game_session_t *);

#endif

