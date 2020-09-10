import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double value;
  final double percent;
  ChartBar({this.label,this.value,this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              "${value.toStringAsFixed(2)}"
            ),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          height: 60,
          width: 10,
          child: Stack(
           // alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5)
                ),
              ),
              //SizedBox fracionado
              FractionallySizedBox(
                /*primeiro forma de resolver o problema da divisão por 0
                * no Widget "Chart" ao Chamar o ChatBar passando o percent
                * Aqui só é exibido o percentual quando o percentual for maior que 0
                * caso contrário, é atribuido o valor 0
                * heightFactor: percent > 0 ? percent : 0,
                * */
                heightFactor: percent,

                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5,),
        Text(
          label
        )
      ],
    );
  }
}
