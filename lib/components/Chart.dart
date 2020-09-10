import 'package:expenses/components/ChartBar.dart';
import 'package:expenses/model/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );

      double totalSum = 0.0;
      for(var i = 0; i < recentTransaction.length; i++){
        bool sameDay = recentTransaction[i].dateTime.day == weekDay.day;
        bool sameMonth = recentTransaction[i].dateTime.month == weekDay.month;
        bool sameYear = recentTransaction[i].dateTime.year == weekDay.year;

        if(sameDay && sameMonth && sameYear){
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day':  DateFormat.E().format(weekDay)[0],
        'value': totalSum
      };
    }).reversed.toList();
  }

  //total da semana
  double get _weekTotalValue{
    /*função fold tem o acumulador e o elemento atual e faz alguma operação
    * retornando o elemento usado como acumulador da proxima intereação*/
    return groupedTransaction.fold(0.0, (acc,item){
      return acc + item['value'];
    });
  }

  double percent;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((tr){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                /*primeira forma
                * percent: (tr['value'] as double) / _weekTotalValue,*/
                //correção da divisão por 0
                /*com o operador ternário só vai ser feito a divisão quando o valor
                * da semana for maior que 0*/
                percent: _weekTotalValue == 0.0 ? 0.0 :(tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
