%{
  #include<stdio.h>
  #include<stdlib.h>
  #include"tradutor.h"
%}

%union {
  char *c;
}

%token <c> NOME
%token <c> CONTEUDO
%token <c> CLASSE
%token <c> PACOTE
%token <c> AUTOR
%token <c> TITULO
%token BEGINDOCUMENT

%%
documentoLatex: configuracao identificacao principal

configuracao: CLASSE PACOTE | CLASSE;

principal: inicio corpoLista fim;

inicio: BEGINDOCUMENT;

fim: "\end{document}";

corpoLista: "\chapter{"NOME"}" corpo capitulo | corpo;

capitulo: "\chapter{"NOME"}" corpo capitulo | "\chapter{"NOME"}";

secao: "\section{"NOME"}" corpo secao | corpo;

subsecao: "\subsection{"NOME"}" corpo subsecao | corpo;

corpo: texto | texto corpo | textoEstilo corpo | listas corpo;

texto: "\paragraph{"CONTEUDO"}";

textoEstilo: "\bf{"CONTEUDO"}" | "\underline{"CONTEUDO"}" | "\it{"CONTEUDO"}";

listas: listaNumerada | listaItens;

listaNumerada: "\begin{enumerate}" itensLNumerada "\end{enumerate}";

itensLNumerada: "\item{"CONTEUDO"}" | "\item{"CONTEUDO"}" itensLNumerada | listas;

listaItens: "\begin{itemize}" itensLItens "\end{itemize}";

itensLItens: "\item{"CONTEUDO"}" | "\item{"CONTEUDO"}" itensLItens | listas;
%%
