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
};
