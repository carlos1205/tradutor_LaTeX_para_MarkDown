%option noyywrap
%{
#include<stdlib.h>
%}

PALAVRA [a-zA-Z]+
ESPACO  " "
NOME    ({PALAVRA}*{ESPACO}*)+
NUMBER  [0-9]+
NEWLINE \n
CONTEUDO ({PALAVRA}*{ESPACO}*{NEWLINE}*)+

%%

"\\begin{document}"         { printf("BEGINDOCUMENT"); }
"\\begin{enumerate}"        { printf("BEGINENUMERATE"); }
"\\begin{itemize}"          { printf("BEGINITEMIZE"); }
"\\end{itemize}"            { printf("ENDITEMIZE"); }
"\\end{enumerate}"          { printf("ENDENUMERATE"); }
"\\end{document}"           { printf("Reconhecido: %s", yytext); }
{NUMBER}                    { printf("NUMBER: %s", yytext); }
{NOME}                      { printf("Nome: %s", yytext); }
"\\chapter"                 { printf("CHAPTER");}
"}"                         { printf("}");}
"{"{CONTEUDO}"}"            { printf("Conteudo: %s\n", yytext);}
"\\usepackage{"{PALAVRA}"}"        { printf("Package: %s", yytext);}

"\\documentclass{"{PALAVRA}"}"     { printf("CLASSE: %s", yytext);}


.                           { puts("não reconhecido"); }
%%

int main(argc, argv)
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
}


