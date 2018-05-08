# The following two macros set up the compiler flags and compiler command

DFLAGS = -DDEBUG -g
CFLAGS = -Wall 
CC = gcc
PROG = vcrec vcsend

all: 	tcp

# Default rule to compile files using the same CC command
%:	%.c
	$(CC) $(DFLAGS) $(CFLAGS) $< -o $@

# Start of the target section
tcp:	$(PROG)
clean:
	rm $(PROG)
