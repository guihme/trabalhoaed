#include<stdio.h>
#include<stdlib.h>
#include<malloc.h>
#include<string.h>
#include <tad.h>

void inicializarLista(LISTA* p) {
    p->inicio = NULL;
    p->soma = 0;
}

PONT busca(LISTA* p, char produto[50], PONT* antes) {
    *antes = NULL;
    PONT atual = p->inicio;
    while ((atual != NULL) && (strcmp(atual->reg.nome, produto) != 0)) {
        *antes = atual;
        atual = atual->prox;
    }
    if((strcmp(atual->reg.nome, produto) == 0)) return NULL;
    return atual;
}
int inserirElemento(LISTA* p, REGISTRO novo) {
    PONT antes, i;
    i = busca(p, novo.nome, &antes);
    if(i == NULL) return 0;
    i = (PONT) malloc(sizeof(ELEMENTO));
    i->reg = novo;
    if(antes == NULL) {
        i->prox = p->inicio;
        p->inicio = i;
    } else{
        i->prox = antes->prox;
        antes->prox = i;
    }
}
//testando clonagem