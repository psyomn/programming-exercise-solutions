/*
 * Write a program which will take string inputs "A", "B", "C", "D", "E", "F",
 * and
 * "G", and make the corresponding notes, in any method of your choosing.
 *
 * Thanks to electric\_machinery for this challenge!
 *
 * http://www.linuxjournal.com/article/6735?page=0,1
 */

#include <stdio.h>

void
play_note(char);

int
is_note(char);

int
main(int argc, char** argv) {
  char** const notes = argv;
  int note_count = argc;
  int i;
  char current_note;

  for (i = 0; i < note_count; i++) {
    current_note = notes[i][0];

    if (is_note(current_note))
      play_note(current_note);
  }

  printf("\n");

  return 0;
}

void
play_note(char note) {
  printf("%c ", note);
}

int
is_note(char note) {
  note = note <= 90 ? note + 32 : note;
  return note < 123 && note >= 97;
}
