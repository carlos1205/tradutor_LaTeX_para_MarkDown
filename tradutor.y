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
%token <string>PACOTE
%type  <string>principal

%%
documentoLatex: configuracao identificacao principal

configuracao: 
%empty |
CLASSE PACOTE {
  char *c = "\n[//]: # (markdown class:)";
  char *p = "\n[//]: # (markdown package:)\n";
  addref(c);
  addref(p); 
}
| CLASSE { addref("\n[//]: # (markdown class):"); 
           addref($1);
}
;

identificacao: TITULO AUTOR {
  char *t = "\n[//]: # (markdown title:)\n";
  char *a = "\n[//]: # (markdown author:)\n";
  addref(t);
  addref(a);
}| TITULO {
  addref("\n[//]: # (markdown title:)");
  addref($1);
}
;

principal: %empty
  | inicio fim { }
  | inicio corpoLista fim { }
;

inicio: BEGINDOCUMENT { addref("\n[//]: # (BEGIN MARKDOWN)\n"); }
;

fim: ENDDOCUMENT { addref("\n[//]: # (END MARKDOWN)\n"); }
;

corpoLista: CONTEUDO { addref($1);}
;

/* corpoLista: "\chapter{"NOME"}" corpo capitulo | corpo;

capitulo: CHAPTER '{' NOME '}' corpo capitulo | "\chapter{"NOME"}";

secao: "\section{"NOME"}" corpo secao | corpo;

subsecao: "\subsection{"NOME"}" corpo subsecao | corpo;

corpo: texto | texto corpo | textoEstilo corpo | listas corpo;

texto: "\paragraph{"CONTEUDO"}" {
  fprintf("saida.md", "\n%s",$1);
};

textoEstilo: "\bf{"CONTEUDO"}" | "\underline{"CONTEUDO"}" | "\it{"CONTEUDO"}";

listas: listaNumerada | listaItens;

listaNumerada: "\begin{enumerate}" itensLNumerada "\end{enumerate}";

itensLNumerada: "\item{"CONTEUDO"}" | "\item{"CONTEUDO"}" itensLNumerada | listas;

listaItens: "\begin{itemize}" itensLItens "\end{itemize}";

itensLItens: "\item{"CONTEUDO"}" | "\item{"CONTEUDO"}" itensLItens | listas; */ 
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
