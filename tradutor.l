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
NUMBER       [0-9]+
LETRAS       [a-zA-Z]+
ESPACO       " "+
FRASE        ({LETRAS}*{ESPACO}*{NUMBER}*)+
NEWLINE      \n

TAG          ({FRASE}+","*)+
DESC         "["+{ESPACO}*{TAG}+{ESPACO}*"]"+
TIPE         "{"{FRASE}"}"
CLASS        "\\documentclass"{DESC}?{TIPE}
PACKAGE      "\\usepackage"{DESC}?{TIPE}
%%

"\\begin{document}"                     { yylval.string = yytext;  return BEGINDOCUMENT; }
"\\end{document}"                       { yylval.string = yytext;  return ENDDOCUMENT; }
{CLASS}                                 { yylval.string = yytext;  return CLASSE;}
{PACKAGE}                               { yylval.string = yytext;  return PACOTE;}
{FRASE}                                 { yylval.string = yytext;  return CONTEUDO;}

{NEWLINE}                               { /*Ignora quebra de linha*/}
.                                       { yyerror("Token não reconhecido^: ");}
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


