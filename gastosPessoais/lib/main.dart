import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gastosPessoais/components/chart.dart';
import 'package:intl/intl.dart';
import 'models/transaction.dart';
import './components/transaction_list.dart';
import 'components/chart.dart';
import 'components/classValor.dart';

main() => runApp(ExpensessApp());

//Organizando as fontes
class ExpensessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
    );
  }
}

Valor temporaria = Valor();

class MyHomePage extends StatefulWidget {
  final num valoraux;

  MyHomePage({this.valoraux = 0.0});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

TextEditingController _controllerSaldo = TextEditingController();

//Lista de transações para o grafico
class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  num valor = 0;
  num temp = 0;
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

//Função para atualizar o saldo
  atualizaValorAppBar() {
    setState(() {
      temporaria.valorAuxiliarTemporaria =
          temporaria.valorAuxiliarTemporaria - widget.valoraux;
    });
  }

//Função para adicionar uma nova transação
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

//Função para excluir uma transação
  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

//Botão para abrir uma nova transação e atualiza o saldo
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
    atualizaValorAppBar();
  }

//App Bar, mostra o valor do saldo e possui o botão para adicionar saldo
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Saldo: R\$ ${temporaria.valorAuxiliarTemporaria}'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_balance_wallet_rounded, color: Colors.white),
          onPressed: () => showAlertDialog3(context),
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.indigo,
            ],
          ),
        ),
      ),
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: availableHeight * 0.29,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: availableHeight * 0.61,
              child: TransactionList(_transactions, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

//Função para adicionar saldo
  showAlertDialog3(BuildContext context) {
    var alert = Container(
        color: Color.fromRGBO(81, 85, 90, 1),
        child: AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
          title: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Center(child: Text('Adicione um saldo!')),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: TextFormField(
                    controller: _controllerSaldo,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Digite o valor", hintText: "R\$1000.00"),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Center(
                  child: Container(
                    width: 189,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: Text(
                        "adicionar valor",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          temporaria.valorAuxiliarTemporaria +=
                              double.parse(_controllerSaldo.text);
                        });
                        _controllerSaldo.text = "";
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [],
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

//Função para verificar se a nova transação é valida
class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  num auxiliar = 0;
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

//Função para abrir o calendário
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

//Tela de nova transação
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            controller: _valueController,
            keyboardType: TextInputType.number,
            onTap: () {
              _submitForm();
            },
            decoration: InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : DateFormat('dd/MM/y').format(_selectedDate),
                  ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _showDatePicker,
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text('Nova Transação'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () {
                  _submitForm();

                  auxiliar = 0;
                  setState(() {
                    temporaria.valorAuxiliarTemporaria =
                        temporaria.valorAuxiliarTemporaria -
                            double.parse(_valueController.text);
                  });

                  _valueController.text = '0';
                },
              ),
            ],
          )
        ]),
      ),
    );
  }
}
