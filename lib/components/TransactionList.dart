import 'package:expenses/model/Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {


  final List<Transaction> transactions;
  final void Function(String) removeTransaction;
  TransactionList(this.transactions,this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          Text(
            "Nenhuma Transação cadastrada!",
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 20,),
          Container(
            height: 200,
              child: Image.asset(
                "assets/images/waiting.png",
                fit: BoxFit.cover,)
          )
        ],
      )
          :ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index){
          final tr = transactions[index];
          return Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                        'R\$${tr.value}',
                    ),
                  ),
                ),
              ),
              title: Text(
                tr.title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(tr.dateTime)
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_sweep),
                onPressed: (){
                  removeTransaction(tr.id);
                },
                color: Theme.of(context).errorColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
