%option noyywrap
%{
#include<stdlib.h>
%}

PALAVRA [a-zA-Z]+
ESPACO  " "
NOME    ({PALAVRA}*{ESPACO}*)+
BEGIN   "\\begin{"
END     "\\end{"
FINISH  "}"

%%

"\\begin{document}"  |
"\\begin{enumerate}" |
"\\begin{itemize}"   |
"\\end{itemize}"     |
"\\end{enumerate}"   |
"\\end{document}"    {printf("Reconhecido: %s\n", yytext);}

{NOME}                 {printf("Nome: %s", yytext);}

.                      {puts("não reconhecido");}
%%

main(argc, argv)
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
}


