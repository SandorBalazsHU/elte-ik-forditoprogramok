while-compile: while.cc lex.yy.cc
	g++ -o while while.cc lex.yy.cc

while-flex: while.l
	flex while.l

clean:
	rm -f lex.yy.cc while