import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AdaptativeButton.dart';
import 'AdaptativeDatePicker.dart';
import 'AdaptativeTextField.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double,DateTime) onSubmited;
  TransactionForm(this.onSubmited);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime selectedDate = DateTime.now(); //definindo data inicial para não precisar forçar o usuario a por uma data;

  _submitForm(){
    /*
   1 - forma
   onSubmited(titleController.text, double.parse(valueController.text));
   */
    // 2- forma
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    //validação
    if(title.isEmpty || value<=0 || selectedDate == null){
      return ;
    }

    widget.onSubmited(title,value,selectedDate);
  }
/*
  _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return null;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

 */

  @override
  Widget build(BuildContext context) {
    return
      Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: 'Título',
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              /*
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Titulo",
                ),
                onSubmitted: (valor){
                  _submitForm();
                },
              ),
              TextField(
                //com Ios não funciona o separador de casa decimal
                //keyboardType: TextInputType.number,
                //forma abaixo funciona tanto para android como Ios
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: valueController,
                decoration: InputDecoration(
                  labelText: "Valor (R\$)",
                ),
                onSubmitted: (valor){
                  _submitForm();
                },
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}
