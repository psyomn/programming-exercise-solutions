#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "list.h"

#define WORDS_FILE "words.txt"

int* mint();
double* dint();
char* cint();

int main(int argc, char * argv[]){
  list_t * list = list_create();

  double* dumber = malloc(sizeof(double));
  char* names;

  *dumber = 12.12;
  list->head = dumber;

  dumber = malloc(sizeof(double));
  *dumber = 83.311;
  list_add_node(list, (void *) dumber);

  dumber = malloc(sizeof(double));
  *dumber = 912.12;
  list_add_node(list, (void *) dumber);

  list_print(list, LIST_PRINT_DOUBLE);
  list_remove_last(list);
  list_print(list, LIST_PRINT_DOUBLE);
  list_destroy(&list);
  list_print(list, LIST_PRINT_DOUBLE);
  
  list = list_create();
  list->head = "llama";
  names = cint();
  strcpy(names, "cat");
  list_add_node(list, (void *) names);

  names = cint();
  strcpy(names, "dog");
  list_add_node(list, (void *) names);

  names = cint(99); // see what I did there?
  strcpy(names, "politician");
  list_add_node(list, (void *) names);

  list_print(list, LIST_PRINT_STRING);

  return 0;
}

int * mint() { return malloc(sizeof(int)); }
double * dint() { return malloc(sizeof(double)); }
char * cint(size_t c) { return malloc(sizeof(char)*c); }


