import 'package:flutter/material.dart';
import 'package:dxmdemo01/constant/Constants.dart';
import 'package:dxmdemo01/event/LoginEvent.dart';

class MyInfoPage extends StatefulWidget {
  

  @override
  MyInfoPageState createState(){
    return new MyInfoPageState();
  }
}

class MyInfoPageState extends State<MyInfoPage> with WidgetsBindingObserver{
  
  @override
  void initState() {
    super.initState();

    Constants.eventBus.on<LoginEvent>().listen((event) {
      print("fire event is ok");
      setState(() {
              print("重置");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
     children: <Widget>[
       Text('Hello')
     ],
    );
  }

}