%option noyywrap
%{
#include<stdlib.h>
%}

PALAVRA [a-zA-Z]+
ESPACO  " "
NOME    ({PALAVRA}*{ESPACO}*)+

%%

"\\begin{document}"  { return BEGIN; }
"\\begin{enumerate}" |
"\\begin{itemize}"   |
"\\end{itemize}"     |
"\\end{enumerate}"   |
"\\end{document}"    {printf("Reconhecido: %s\n", yytext);}

{NOME}                 {printf("Nome: %s", yytext);}

apaga isso aqui


.                      {puts("não reconhecido");}
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


