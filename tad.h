#include<stdio.h>
#include<stdlib.h>
#include<malloc.h>

typedef struct {
    char nome[50];
    double valor;
    int qtd;
} REGISTRO;

typedef struct aux {
    REGISTRO reg;
    struct aux* prox;
} ELEMENTO;

typedef ELEMENTO* PONT;

typedef struct {
    PONT inicio;
    double soma;
} LISTA;

void inicializarLista(LISTA* p);
PONT busca(LISTA* p, char produto[50], PONT* antes);
int inserirElemento(LISTA* p, REGISTRO novo);
