#include "tad.c"
#define MAX 100

int main(){
LISTA lista;
PONT pont;
REGISTRO reg;
ELEMENTO elem;
inicializarLista(&lista);
int comanda[MAX], opcao, i, j, Ncomandas, qtdProd,qtd;
char nome[50];
double preco;

//Menu

printf("0-Parar programa\n1-Criar comanda\n2-Inserir produtos na comanda\n3-Excluir produtos da comanda\n4-Exibir comanda\n5-Comanda paga(excluir)\n");
scanf("%d", &opcao);
 while (opcao != 0)
 {
     scanf("%d", &opcao);
     switch (opcao){
     case 1:
     //Criar comanda
     printf("Numero de comandas: ");
     scanf("%d", &Ncomandas);
       for (i= 0; i < Ncomandas; i++){
           printf("Quantidade de produtos a serem inseridos: ");
           scanf("%d", qtdProd);
           for (j = 0; j < qtdProd; j++){
            printf("\nNome do produto: ");
           scanf("%s", reg.nome);
           //reg.nome = nome;
           printf("\nPreço: R$ ");
           scanf("%.2lf", &preco);
           reg.valor = preco;
           printf("\nQuantidade: ");
           scanf("%d", &qtd);
           reg.qtd = qtd;
           }    
        comanda[i] = reg.nome;
        comanda[i] = reg.valor;
        comanda[i] = reg.qtd;
     }
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
     //Marcar comanda como paga(excluir)
     break;
     }
 }
 
}