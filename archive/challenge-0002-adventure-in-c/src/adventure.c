/*
 * @author Simon Symeonidis 
 * @date Fri Jun 14 2013
 * 
 * This is a challenge from:
 *   http://www.reddit.com/r/dailyprogrammer/comments/pjbuj/ 
 * 
 *   Create a short text adventure that will call the user by their name. The 
 *   text adventure should use standard text adventure commands ("l, n, s, e, i, 
 *   etc.").
 *
 *   For extra credit, make sure the program doesn't fault, quit, glitch, fail, 
 *   or loop no matter what is put in, even empty text or spaces. These will be 
 *   tested rigorously! For super extra credit, code it in C
 *
 */

#include <stdio.h>
#include <string.h>

#include "game_controller.h"
#include "static.h"

int main(int argc, char * argv[])
{
  printf("%s v%s by %s\n\n", ADVENTURE_APP_NAME, 
    ADVENTURE_APP_VERSION, ADVENTURE_APP_AUTHOR);

  printf("You're supposed to find the exit to the somewhat\n"
    "maze-y map. If you hit your head against the wall too many\n"
    "times you sustain too much brain damage and die.\n"
    "\n"
    "(If you're wondering, I get many requests to write plot lines\n"
    "for video games)\n\n");

  game_controller_new_session();
  return 0;
}
