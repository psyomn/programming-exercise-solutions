#include <stdio.h>
#include <stdlib.h>
#include "list.h"

void list_print_int(list_t*);
void list_print_string(list_t*);
void list_print_double(list_t*);

void 
list_add_node(list_t** list, void* data){
  if (!list){ perror("list is null"); return;}

  list_t * old_head = *list;
  list_t * node = list_create();
  node->head = data;
  node->tail = old_head;
  *list = node;
}

/* Very inefficient - took 1 minute to add 52k elements in a list vs head
   insertions. */
void
list_add_node_tail(list_t* list, void* data){
  if (!list){ perror("list is null"); return;}

  list_t * tail = list_find_tail(list);
  list_t * node = list_create();
  node->head = data;
  tail->tail = node;
}

void 
list_print(list_t * list, size_t as){
  if (list == 0){
    printf("<>\n");
    return;
  }

  switch(as){
  case LIST_PRINT_INT:    list_print_int(list);    break;
  case LIST_PRINT_DOUBLE: list_print_double(list); break;
  case LIST_PRINT_STRING: list_print_string(list); break;
  }
}

void
list_print_string(list_t * list){
  list_t * nav = list;
  printf("<'%s'", (char *) nav->head);
  if (nav != 0) printf(", ");
  nav = nav->tail;
  while (nav != 0){
    printf("'%s'", (char *) nav->head);
    nav = nav->tail;
    if (nav != 0) printf(", ");
  }
  printf(">\n");    
}

void 
list_print_double(list_t * list){
  list_t * nav = list;
  printf("<%f", *(double *) nav->head);
  if (nav != 0) printf(", ");
  nav = nav->tail;
  while (nav != 0){
    printf("%f", *(double *) nav->head);
    nav = nav->tail;
    if (nav != 0) printf(", ");
  }
  printf(">\n");    
}


void 
list_print_int(list_t * list){
  list_t * nav = list;
  printf("<%d", *(int *) nav->head);
  if (nav != 0) printf(", ");
  nav = nav->tail;
  while (nav != 0){
    printf("%d", *(int *) nav->head);
    nav = nav->tail;
    if (nav != 0) printf(", ");
  }
  printf(">\n");
}

list_t * 
list_create(){
  list_t * list = malloc(sizeof(list_t));
  list->head = 0;
  list->tail = 0;
  return list; 
}

/* WARRRGAGLBAGL */
void 
list_destroy(list_t** list){
  list_t * tmp; 
  list_t * tmp2;

  if (*list){
    if ((*list)->head) free((*list)->head);
    (*list)->tail = 0;
    tmp = (*list)->tail;
    *list = 0;
    free(*list);
    while(tmp != 0){
      if (tmp->head) free(tmp->head);
      tmp->tail = 0;
      tmp2 = tmp->tail;
      free(tmp);
      tmp = tmp2;
    }
  }
  else {
    perror("list_destroy: You provided a null list");
  }
}

list_t* 
list_find_tail(list_t* list){
  list_t* nav = list;

  while(nav->tail != 0){
    nav = nav->tail;
  }

  return nav;
}
list_t* 
list_find_second_to_last(list_t* list){
  list_t* nav = list;

  while(nav->tail != 0 && nav->tail->tail != 0){
    nav = nav->tail;
  }

  return nav;
}

void
list_remove_last(list_t* list){
  list_t* tail = list_find_tail(list);
  list_t* seco = list_find_second_to_last(list);
  _list_destroy_node(tail);
  seco->tail = 0;
}

void
_list_destroy_node(list_t* list){
  free(list->head);
  free(list);
}

