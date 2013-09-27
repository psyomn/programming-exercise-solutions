#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define DATA_FILENAME "credentials.dat"

void read_credentials(char**,char**);
void ctest(char*);
void chomp(char**,size_t);

int main(int argc, char * argv[]){
  char password[50]; 
  char username[50];
  char * r_pass = NULL;
  char * r_user = NULL;
  char * test;

  read_credentials(&r_pass,&r_user);

  printf("(Read password: '%s')\n", r_pass);
  printf("(Read username: '%s')\n", r_user);

  printf("Enter username : ");
  scanf("%s", username);
  printf("Enter password : ");
  scanf("%s", password);

  if (!strcmp(r_user,username) && !strcmp(r_pass,password))
    printf("You are AUTHORIZED!\n");
  else
    printf("Wrong password or username! YOU WILL BE INCINERAAAATTEEED.\n"
           "INCCIIIIIINEEEERAAAATTEEEED\n\n");

  return 0;
}

/** Read the file for credentials {username, password} */
void read_credentials(char** password, char** username){
  FILE * file;
  int    lines   = 2, i = 0;
  size_t spass   = 0;
  size_t suser   = 0;
  char   delim[] = ":\n\r";
  char*  tmp;

  file = fopen(DATA_FILENAME, "r");

  if (file) {
    /* Want a 2 lined file */
    for ( ; i < lines; ++i){
      if(0 == i) getline(&*password, &spass, file);
      if(1 == i) getline(&*username, &suser, file);
    }

    *password = (strtok(*password, delim) + 2);
    *username = (strtok(*username, delim) + 2);

    chomp(password, strlen(*password));
    chomp(username, strlen(*username));
  }
  else {
    perror("Problem opening file");
  }
  fclose(file);
}

/** Chomp \n or \r characters by replacing them with \0 */
void chomp(char** str, size_t len){
  size_t ix;

  for (ix = 0; ix < len; ++ix){
    if ((*str)[ix] == '\n' || (*str)[ix] == '\r') (*str)[ix] = '\0';
  }
}
