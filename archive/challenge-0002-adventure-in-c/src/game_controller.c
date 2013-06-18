#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>

#include "game_controller.h"
#include "game_map.h"
#include "node.h"
#include "game_map.h"
#include "biological.h"
#include "static.h"
#include "tprint.h"

/** Do some standard game initializements */
void
game_controller_init(){
  srand(time(NULL));
}

/** Start a game session */
void
game_controller_start(){
}

/** Start a battle session */
void
game_controller_battle(){
}

/**
 * Create a new game session that we can use in order to play a game.
 */
void
game_controller_new_session(){
  char             cmd_buffer[50];
  char             name[50];
  int              is_done   = 0;
  game_session_t * game_session;

  game_session = create_game_session();
  game_controller_init();

  printf("What is your name? : ");
  scanf("%s", name);
  printf("Hello %s, I want to play a game.\n", name);

  while (!is_done){
    memset(cmd_buffer, 0, sizeof(cmd_buffer));
    scanf("%s", cmd_buffer);

    if (!strcmp(cmd_buffer, "end")  || 
        !strcmp(cmd_buffer, "quit") ||
        !strcmp(cmd_buffer, "exit") ||
        cmd_buffer[0] == 'q') is_done = 1;

    else {
      switch(cmd_buffer[0]){
      case 'n':
        tprint("Move north\n");
        game_controller_move_player(game_session, ADVENTURE_MOVE_UP);
        break;
      case 's':
        tprint("Move south\n");
        game_controller_move_player(game_session, ADVENTURE_MOVE_DOWN);
        break;
      case 'w':
        tprint("Move west\n");
        game_controller_move_player(game_session, ADVENTURE_MOVE_LEFT);
        break;
      case 'e':
        tprint("Move east\n");
        game_controller_move_player(game_session, ADVENTURE_MOVE_RIGHT);
        break;
      case 'l':
        tprint("You look around...\n");
        game_controller_look(game_session);
        game_map_print(game_session->map);
        break;
      case 'h':
        tprint("Help --\n"
               "  n - move north\n"
               "  s - move south\n"
               "  w - move west\n"
               "  e - move east\n"
               "  l - look at current room\n"
               "  q - quit this application\n"
               "  h - print this information\n");
      case 'i': /* Check yo self b4 u wrek yo self */
        biological_print(game_session->player);
        break;
      default:
        tprint("For help on commands, type 'h'\n");
        break;
      }
    }
  }
  tprint("Bye\n");
}

/**
 * Create the game session. 
 * @return a game session struct with a player, and map initialized.
 */
game_session_t *
create_game_session(){
  game_map_t     * gmap;
  biological_t   * player;
  game_session_t * game_session = malloc(sizeof(game_session_t));

  gmap = game_map_create();
  game_map_randomize(gmap,0);

  player = biological_create();

  game_session->map = gmap;
  game_session->player = player;
  game_session->player_position_x = 0;
  game_session->player_position_y = 0;

  gmap->data[game_session->player_position_x]
            [game_session->player_position_y].p = 'O';

  gmap->data[game_session->player_position_x]
            [game_session->player_position_y].visited = '.';

  return game_session;
}

/**
 * We use this to move the player on the map (similar to a command
 * pattern)
 *
 * @param direction
 *   is the direction in which the player wishes to move
 * @param gs
 *   is the current game session
 */
void
game_controller_move_player(game_session_t * gs, uint16_t direction){
  gs->map->data
    [gs->player_position_x]
    [gs->player_position_y].p = ' ';

  if (game_controller_can_move(gs, direction)){
    switch(direction){
    case ADVENTURE_MOVE_UP:
        --gs->player_position_y; break;
    case ADVENTURE_MOVE_DOWN:
        ++gs->player_position_y; break;
    case ADVENTURE_MOVE_LEFT:
        --gs->player_position_x; break;
    case ADVENTURE_MOVE_RIGHT:
        ++gs->player_position_x; break;
    }
  }

  else {
    tprint("Bump! You hit your nose on the wall. And leave a bloody smear.\n");
    node_add_message(& gs->map->
                     data[gs->player_position_x][gs->player_position_y],
                     ADVENTURE_MSG_NOSE_BLOOD_SMEAR_ID);
  }

  gs->map->data
    [gs->player_position_x]
    [gs->player_position_y].visited = '.';

  gs->map->data
    [gs->player_position_x]
    [gs->player_position_y].p = 'O';
}

/**
 * Check to see if you can move in a direction
 * TODO: Crappy code. Will fix later.
 * @param gs 
 *   is the current game session
 * @param direction 
 *   is the direction (n,s,w,e)
 */
int
game_controller_can_move(game_session_t * gs,
                         char direction){
  int ret;
  switch(direction){
    case ADVENTURE_MOVE_UP:
      ret = (gs->player_position_y > 0) &&
            (gs->map->data[gs->player_position_x][gs->player_position_y].n); break;
    case ADVENTURE_MOVE_DOWN:
      ret = (gs->player_position_y + 1 < gs->map->height) &&
            (gs->map->data[gs->player_position_x][gs->player_position_y].s); break;
    case ADVENTURE_MOVE_LEFT:
      ret = (gs->player_position_x > 0) &&
            (gs->map->data[gs->player_position_x][gs->player_position_y].w); break;
    case ADVENTURE_MOVE_RIGHT:
      ret = (gs->player_position_x + 1 < gs->map->width) &&
            (gs->map->data[gs->player_position_x][gs->player_position_y].e); break;
  }
  return ret; 
}

/**
 * Delegation to look of the node function. 
 * @param gs
 *   is the game session to extract the map from, and describe it.
 */
void
game_controller_look(game_session_t * gs){
  node_look(
    &gs->map->data
       [gs->player_position_x]
       [gs->player_position_y]
  );
}

