import 'package:expenses/ExpensesApp.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.amber,
      fontFamily: 'OpenSans',
      //alterando a fonte do AppBar
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        )
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
        title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
        )
      )
    ),
  ));
}