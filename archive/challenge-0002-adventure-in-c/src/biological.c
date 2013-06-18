#include "biological.h"
#include <stdlib.h>
#include <stdio.h> 

/**
 * Shorthand to mem allocation of biological_t structs, and 
 * initialization 
 * @return 
 *   a pointer to the struct of biological type in memory
 */
biological_t *
biological_create(){
  biological_t * b = malloc(sizeof(biological_t));
  b->hitpoints = 10;
  b->attack    = 2;
  return b;
}

/**
 * @param b 
 *   is the biological struct that is passed
 */
int 
biological_is_dead(biological_t * b){
  if (b == NULL) return -1;
  return b->hitpoints <= 0;
}

/**
 * The attack function of the biological struct. Sophisticated
 * formulas may be added here.
 * 
 * @param b
 *   the biological that is attacking
 * @return
 *   the amount of damage that the biological inflicts.
 */
uint16_t 
biological_attack(biological_t * b){
  if (b == NULL) {
    perror("Null pointer at bio attack");
    return 0;
  }
  return b->attack;
}

/**
 * Removes the damage from the biological b, which is inflicted upon.
 * Handles also logic to receive damage. 
 *
 * @param b
 *   is the biological receiving damage
 * @param amount
 *   is the amount of damage being dealt at the current moment.
 */
void
biological_receive_damage(biological_t * b, uint16_t amount){
  if (b == NULL){
    perror("Null pointer at bio receive damage");
    return;
  }

  b->hitpoints =
    b->hitpoints - amount < b->hitpoints ? 
      0 : b->hitpoints - amount;
}

/**
 * Prints the current status of a biological
 * @param b
 *   the biological that we are inspecting.
 */
void
biological_print(biological_t * b){
  printf("Your current stats: \n");
  printf("  %d hitpoints \n", b->hitpoints);
  printf("  %d attack power \n", b->attack);
  printf("\n");
}
