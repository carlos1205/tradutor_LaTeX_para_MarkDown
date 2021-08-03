%{
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>

  void yyerror(char* c);
  int yylex(void);
  void addref(char* c);
%}

/*]
  conexão flex e bison estabelecida,
  Caso queira só flex, retirar #include "y.tab.h" do arquivo flex ou comentar
  o arquivo bison inteiro.
*/

%union {
  char* buffer;
}

%token <buffer> PACOTE AUTOR TITULO CLASSE BEGINDOCUMENT ENDDOCUMENT

%%
documentoLatex: configuracao identificacao principal

configuracao: CLASSE PACOTE {
  char *c = "\n[//]: # (markdown class:)\n";
  char *p = "\n[//]: # (markdown package:)\n";
  addref(c);
  addref(p); 
}
| CLASSE { addref("\n[//]: # (markdown class)"); }
;

identificacao: TITULO AUTOR {
  char *t = "\n[//]: # (markdown title:)\n";
  char *a = "\n[//]: # (markdown author:)\n";
  addref(t);
  addref(a);
}
| TITULO {
  char *t = "\n[//]: # (markdown title:)\n";
  addref(t);
}
;

principal: /* Vazio */
  | inicio corpoLista fim { }
;

inicio: BEGINDOCUMENT { addref("\n[//]: # (begin markdown)"); }
;

fim: ENDDOCUMENT { addref("\n[//]: # (end markdown)"); }
;

corpoLista: /* Vazio */
  |
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
    fprintf("%s\n", c);
  fclose(fclose);
}


int main(){
  yyparse();
  return 0;
}
