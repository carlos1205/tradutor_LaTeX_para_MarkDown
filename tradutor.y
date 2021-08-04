%{
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>

  void yyerror(char* c);
  int yylex(void);
  void addref(char* c);
%}

/*
  conexão flex e bison estabelecida,
  Caso queira só flex, retirar #include "y.tab.h" do arquivo flex ou comentar
  o arquivo bison inteiro.
*/

%union {
  char *string;
}

%token <string>AUTOR <string>TITULO <string>CLASSE BEGINDOCUMENT ENDDOCUMENT
%token <string>CONTEUDO 
%token <string>CAPITULO
%token <string>PACOTE
%type  <string>principal

%%
documentoLatex: configuracao identificacao principal

configuracao: CLASSE PACOTE {
  char *c = "\n[//]: # (markdown class:)";
  char *p = "[//]: # (markdown package:)\n";
  addref(c);
  addref(p); 
}
| CLASSE { addref("\n[//]: # (markdown class):"); 
           addref($1);
}
;

identificacao: TITULO AUTOR {
  char *t = "\n[//]: # (markdown title:)";
  char *a = "[//]: # (markdown author:)";
  addref(t);
  addref(a);
}| TITULO {
  addref("\n[//]: # (markdown title:)");
  addref($1);
}
;

principal: inicio corpoLista fim { }
;

inicio: BEGINDOCUMENT { addref("\n[//]: # (BEGIN MARKDOWN)\n"); }
;

//corpoLista: CAPITULO { addref("\n[//]: # (CAPITULO MARKDOWN)\n"); };

fim: ENDDOCUMENT { addref("\n[//]: # (END MARKDOWN)\n"); }
;
%%


void yyerror(char* c) {
  printf("Erro: %s\n",c);
}

void addref(char *c) {
  FILE *f = fopen("markdown.md", "a");
  if(!f)
    printf("Erro ao abrir arquivo markdown.md");
  else
    fprintf(f,"%s\n", c);
  fclose(f);
}


int main(){
  yyparse();
  return 0;
}
