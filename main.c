#include "tad.h"
#define MAX 100

int main(){
LISTA lista;
PONT pont;
REGISTRO reg;
ELEMENTO elem;
inicializarLista(&lista);
int comanda[MAX], opcao;
//Menu

printf("0-Parar programa\n1-Criar comanda\n2-Inserir produtos na comanda\n3-Excluir produtos da comanda\n4-Exibir comanda\n5-Comanda paga(excluir\n");
scanf("%d", &opcao);
 while (opcao != 0)
 {
     scanf("%d", &opcao);
     switch (opcao){
     case 1:
     //Criar comanda
     break;
     case 2:
     //Inserir produtos na comanda
     break;
     case 3:
     //Excluir produtos da comanda
     break;
     case 4:
     //Exibir comanda
     break;
     case 5: 
     //Marcar comanda como pagar(excluir)
     break;
     }
 }
 
}