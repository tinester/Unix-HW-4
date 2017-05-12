#Zacg Eagan
# zse150030
# # Cs3376.002
CXX = gcc
CXXFLAGS = -Wall
YACC = bison
YFLAGS = -dy
LEX = flex
LFLAGS =
OBJS = prog4.o y.tab.o lex.yy.o

all: prog4

clean: 
	rm $(OBJS) *~ prog4 y.tab.c y.tab.h lex.yy.c

prog4: $(OBJS)
	$(CXX) -o prog4 $(OBJS)

y.tab.c: prog4.y
	$(YACC) $(YFLAGS) $<

lex.yy.c: prog4.l
	$(LEX) $(LFLAGS) $<
