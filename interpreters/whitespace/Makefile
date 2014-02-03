GCC=gcc
LD=$(GCC)
CFLAGS=-Wall
SRC:= stack.c whitespace.c
OBJ:= $(SRC:.c=.o)
TARGET=whitespacei

all: $(OBJ)
	$(LD) $(OBJ) -o $(TARGET)

%.o : %.c
	$(GCC) -c $< -o $@ $(CFLAGS)
