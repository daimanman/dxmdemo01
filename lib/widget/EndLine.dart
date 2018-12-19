import 'package:flutter/material.dart';
class EndLine extends StatelessWidget{
  String msg;
  EndLine({this.msg});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.fromLTRB(5.0,15.0,5.0,15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(height: 10.0,),
            flex: 1,
          ),
          Text(msg??'我是有底线的',style: TextStyle(color:const Color(0xff333333),fontSize: 13.0,decoration: TextDecoration.none)),
          Expanded(
            child: Divider(height: 10.0,),
            flex: 1,
          )
        ],
      ),
    );
  }
}

