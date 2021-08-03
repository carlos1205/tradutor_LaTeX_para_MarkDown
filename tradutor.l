%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"


void yyerror(char* c);
%}


/*
  TENTANDO FAZER ALGO SIMPLES, CONEXÃO COM BISON E FLEX FEITA.
*/
/* NUMBER          [0-9]+ */
LETRAS         [a-zA-Z]+
ESPACO          " "+
/* PALAVRA       {LETRAS}+{ESPACO}* */
/* NOME          {PALAVRA}+{ESPACO}* */

%%

"\\begin{document}"                     { yylval.string = yytext;  return BEGINDOCUMENT; }
end                                    { yylval.string = yytext;  return ENDDOCUMENT; }
USEPACKAGE                              { }
TITLE                                   { }
AUTHOR                                  { }
DOCUMENTCLASS                           { }
.                                       { yyerror("Token não reconhecido^: "); printf(" %s\n",yytext);}
%%

/* int main(argc, argv)
int argc;
char **argv;
{
  if(argc > 1){
    if(!(yyin = fopen(argv[1], "r"))){
      perror(argv[1]);
      return(1);
    }
  }
  yylex();
  return 0;
} */


