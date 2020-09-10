import 'dart:math';

import 'package:expenses/components/Chart.dart';
import 'package:expenses/components/TransactionForm.dart';
import 'package:expenses/components/TransactionList.dart';
import 'package:expenses/model/Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> _transaction = [
   /* Transaction(
        id: "T1",
        title: "Novo tênis",
        value: 20,
        dateTime: DateTime.now()
    ),
    Transaction(
        id: "T2",
        title: "Conta de luz",
        value: 200,
        dateTime: DateTime.now()
    ),

    */
  ];

  //filtrando
  List<Transaction> get _recentTransactions{
    return _transaction.where((tr){
      return tr.dateTime.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime data){
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        dateTime: data
    );
    setState(() {
      _transaction.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id){
    setState(() {
      _transaction.removeWhere((tr){
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return TransactionForm(_addTransaction);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              _openTransactionFormModal(context);
            },
          )
        ],
        title: Text(
            "Despesas Pessoais",
            /*
            alterando a fonte em local especifico
            style: TextStyle(
              fontFamily: 'Quicksand'
            )

             */
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            //antigo
            //TransactionUSer()
            //TransactionForm(_addTransaction),
            TransactionList(_transaction,_removeTransaction)

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _openTransactionFormModal(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

