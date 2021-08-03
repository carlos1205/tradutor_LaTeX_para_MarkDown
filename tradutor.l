%option noyywrap
%{
#include<stdlib.h>
%}

NUMBER [0-9]+
PALAVRA [a-zA-Z]+
ESPACO  " "
NOME    ({PALAVRA}*{ESPACO}*)+

%%

"\\begin{document}"  { printf("BEGINDOCUMENT"); }
"\\begin{enumerate}" { printf("BEGINENUMERATE"); }
"\\begin{itemize}"   { printf("BEGINITEMIZE"); }
"\\end{itemize}"     { printf("ENDITEMIZE"); }
"\\end{enumerate}"   { printf("ENDENUMERATE"); }
"\\end{document}"    { printf("Reconhecido: %s\n", yytext); }
{NUMBER}              { printf("NUMBER: %d\n", yytext); }
{NOME}                 {printf("Nome: %s\n", yytext);}

apaga isso aqui


.                      {puts("não reconhecido");}
%%

int main(argc, argv)
int argc;
char **argv;

  if(argc > 1){
    if(!(yyin = fopen(argv[1], "r"))){
      perror(argv[1]);
      return(1);
    }
  }
  yylex();
  return 0;
}


