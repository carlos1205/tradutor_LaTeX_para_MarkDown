trab: tradutor.l tradutor.y
	bison -dy tradutor.y 
	flex tradutor.l
	gcc -ot lex.yy.c y.tab.c -ll