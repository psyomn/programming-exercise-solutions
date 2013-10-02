#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "list.h"

#define WORDS_FILE "words"

void 
each_line(list_t*);

void
anagram(list_t*);

void
chomp(char *,size_t);

typedef struct {
  char letter;
  int  occur;
} tuple_t;

void
count_chars(tuple_t*,char*);

void
clear_chars(tuple_t*,size_t);

int main(int argc, char * argv[]){
  list_t * list = list_create();

  each_line(list);
  list_print(list, LIST_PRINT_STRING);

  return 0;
}

void 
each_line(list_t* list){
  FILE * fh;
  char * line = 0;
  size_t len = 0;
  char * tmp;

  fh = fopen(WORDS_FILE, "r");

  if (fh) {
    while (getline(&line, &len, fh) != -1){
      tmp = malloc(sizeof(char) * len);
      strcpy(tmp, line);
      chomp(tmp,len);
      list_add_node(&list, (void*) tmp);
    }
    fclose(fh);
  }
  else { 
    perror("each_line");
    exit(-1);
  }
}

void
chomp(char* str, size_t max){
  while(*str){
    if (*str == '\n' || *str == '\r'){
      *str = '\0';
      return;
    }
    --max;
    ++str;
  }
}

/** main subroutine for checking out things. */
void 
anagram(list_t* lst){
  tuple_t pword[27];

  clear_chars(pword ,sizeof(pword));

}

void
count_chars(tuple_t* tup, char* str){
}

void
clear_chars(tuple_t* tup, size_t count){
  do{
    tup[count].letter = 0;
    tup[count].occur = 0;
  }while(--count);
}

