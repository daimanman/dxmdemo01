import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dxmdemo01/pages/day0.dart';
import 'package:dxmdemo01/pages/day1.dart';
import 'package:dxmdemo01/pages/day3.dart';
import 'package:dxmdemo01/pages/dxm1.dart';


class HomePage extends StatelessWidget {
  Widget menuIcons(BuildContext context,Icon icon,String title,Widget nextPage){
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: const BorderSide(color: const Color(0xFFCCCCCC)),
          end: const BorderSide(color: const Color(0xFFCCCCCC)),
        )
      ),
      child: InkWell(
        onTap:(){
          Navigator.of(context).push(CupertinoPageRoute<bool>(
            builder: (BuildContext context) => nextPage,
            ));
        },
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              Container(
                margin: EdgeInsets.only(top:10.0),
                child: Text(title),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text(
          'Flutter Demos Gallery'
        ),
      ),
      body:GridView.count(
        primary: false,
        crossAxisCount: 3,
        children: <Widget>[
           menuIcons(context, Icon(FontAwesomeIcons.contao, size: 48.0, color: Color(0xFFFF9A05)), 'Day0' ,Day0Page()),
           menuIcons(context, Icon(FontAwesomeIcons.stopwatch, size: 48.0, color: Color(0xFFFF856C)), 'Day1' ,Day1Page()),
           menuIcons(context, Icon(FontAwesomeIcons.smile, size: 48.0, color: Color(0xFFFF856C)), 'Dxm1' ,Dxm1Page()),
           menuIcons(context, Icon(FontAwesomeIcons.twitter, size: 48.0, color: Color(0xFFFF856C)), 'Dxm3' ,Day3Page()),
        ],
      ),
    );
  }
  
}