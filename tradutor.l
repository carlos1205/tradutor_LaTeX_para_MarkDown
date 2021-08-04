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
TAB          [ \t]


TAG          ({FRASE}+","*)+
DESC         "["+{ESPACO}*{TAG}+{ESPACO}*"]"+
TIPE         "{"{FRASE}"}"
CLASS        "\\documentclass"{DESC}?{TIPE}
PACKAGE      "\\usepackage"{DESC}?{TIPE}

NOME         ({LETRAS}*{ESPACO}*)+
TITULO       "\\title{"{NOME}"}"
AUTOR        "\\author{"{NOME}"}" 
CAPITU       "\\chapter{"{NOME}"}"    
%%

"\\begin{document}"                     { yylval.string = yytext;  return BEGINDOCUMENT; }
"\\end{document}"                       { yylval.string = yytext;  return ENDDOCUMENT; }
{CLASS}                                 { yylval.string = yytext;  return CLASSE;}
{PACKAGE}                               { yylval.string = yytext;  return PACOTE;}
{TITULO}                                { yylval.string = yytext;  return TITULO;}
{AUTOR}                                 { yylval.string = yytext;  return AUTOR;}
{CAPITU}                                { yylval.string = yytext;  return CAPITULO;}
{FRASE}                                 { yylval.string = yytext;  return CONTEUDO;}

{NEWLINE}                               { /*Ignora quebra de linha*/}
{TAB}                                   { /*Ignora o TAB*/}
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


