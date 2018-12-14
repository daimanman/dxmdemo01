import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dxmdemo01/pages/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primaryColor:Colors.blue,
      ),
      home: HomePage(), 
    );
  }
}
