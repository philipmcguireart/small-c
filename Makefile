#	Requires System V make
#	@(#)Makefile 1.5 86/05/13
.SUFFIXES:	.o .c .c~ .h .h~
.PRECIOUS:	scclib.a
#	You'll probabably want to change these.  These are used by the compilers#	to figure out where the include files should go.
TARGDIR = /u/clewis/lib
INCDIR = "/u/clewis/src/scc/include/"

INSTFLAGS = -DINCDIR=$(INCDIR)
CFLAGS = '$(INSTFLAGS)' -O
AR = ar
ARFLAGS = rv

LIB = scclib.a

FE =	$(LIB)(data.o) \
	$(LIB)(error.o) \
	$(LIB)(expr.o) \
	$(LIB)(function.o) \
	$(LIB)(gen.o) \
	$(LIB)(io.o) \
	$(LIB)(lex.o) \
	$(LIB)(main.o) \
	$(LIB)(preproc.o) \
	$(LIB)(primary.o) \
	$(LIB)(stmt.o) \
	$(LIB)(sym.o) \
	$(LIB)(while.o)

all:	scc8080 sccas09 sccvax sccm68k

$(FE) code8080.o codeas09.o codevax.o codem68k.o: defs.h data.h

install:	all
	mv sccvax scc8080 sccas09 sccm68k $(TARGDIR)

#Alternately, you may have to do an lorder
$(LIB):	$(FE)
	-ranlib $(LIB)
	-ucb ranlib $(LIB)

scc8080:	code8080.o $(LIB)
	$(CC) -o scc8080 $(CFLAGS) $(LIB) code8080.o

sccas09:	codeas09.o $(LIB)
	$(CC) -o sccas09 $(CFLAGS) $(LIB) codeas09.o

sccvax:		codevax.o $(LIB)
	$(CC) -o sccvax $(CFLAGS) $(LIB) codevax.o

sccm68k:	codem68k.o $(LIB)
	$(CC) -o sccm68k $(CFLAGS) $(LIB) codem68k.o

print:
	pr -n defs.h data.h data.c error.c expr.c function.c gen.c \
		io.c lex.c main.c preproc.c primary.c stmt.c \
		sym.c while.c code*.c | lp
clean:
	rm -f $(LIB) code8080.o codeas09.o codevax.o codem68k.o \
		     sccvax scc8080 sccas09 sccm68k
