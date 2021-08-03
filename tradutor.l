%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"


void yyerror(char* c);
%}

NUMBER          [0-9]+
LETRAS         [a-zA-Z]+
ESPACO          " "+
PALAVRA       {LETRAS}+{ESPACO}*
NOME          {PALAVRA}+{ESPACO}*

%%

"begin"                                   { return BEGINDOCUMENT; }
"end"                                     { return ENDDOCUMENT; }
"usepackage"                              { return PACOTE; }
"title"                                   { return TITULO; }
"author"                                  { return AUTOR; }
"documentclass"                           { return CLASSE; }
.                                         { yyerror("Token não reconhecido\n"); }
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


