#ifndef _LIST_H_
#define _LIST_H_

#define LIST_PRINT_INT     1
#define LIST_PRINT_DOUBLE  2
#define LIST_PRINT_STRING  3
#define LIST_PRINT_CUSTOM  4

struct list {
  void        * head; 
  struct list * tail;
};

typedef struct list list_t;

void list_add_node(list_t*, void*);

void list_print(list_t*, size_t);

list_t * list_find_tail(list_t*);
list_t * list_find_second_to_last(list_t*);

list_t * list_create();
void     list_destroy(list_t**);

void list_remove_last(list_t*);
void _list_destroy_node(list_t*);

#endif /* _LIST_H_ */

