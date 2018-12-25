import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dxmdemo01/pages/day0.dart';
import 'package:dxmdemo01/pages/day1.dart';
import 'package:dxmdemo01/pages/day3.dart';
import 'package:dxmdemo01/pages/dxm1.dart';
import 'package:dxmdemo01/pages/LoginPage.dart';
import 'package:dxmdemo01/pages/ArticleDetailPage.dart';
import 'package:dxmdemo01/pages/AboutUsPage.dart';
import 'package:dxmdemo01/widget/EndLine.dart';
import 'package:dxmdemo01/pages/HomeListPage.dart';
import 'package:dxmdemo01/pages/ArticleListPage.dart';
import 'package:dxmdemo01/http/Api.dart';
import 'package:dxmdemo01/pages/TreePage.dart';
import 'package:dxmdemo01/pages/WanApp.dart';


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
           menuIcons(context, Icon(FontAwesomeIcons.sign, size: 48.0, color: Color(0xFFFF856C)), 'Login' ,LoginPage()),
           menuIcons(context, Icon(FontAwesomeIcons.desktop, size: 48.0, color: Color(0xAAFF856C)), 'WebView' ,ArticleDetailPage(title: 'webview',url: 'http://192.168.1.53:7777/vw')),
           menuIcons(context, Icon(FontAwesomeIcons.user, size: 48.0, color: Color(0xCC22856C)), 'About me' ,AboutUsPage()),
           menuIcons(context, Icon(FontAwesomeIcons.database, size: 48.0, color: Color(0xAAC22856C)), 'About me' ,EndLine(msg: '实在拉不出来了',)),
           menuIcons(context, Icon(FontAwesomeIcons.home, size: 48.0, color: Color(0xCC00857C)), 'HomePageList' ,HomeListPage()),
           menuIcons(context, Icon(FontAwesomeIcons.desktop, size: 48.0, color: Color(0xCCBB0857C)), 'HomePageList' ,ArticleListPage(urlCallback: (curPage){
              String url = Api.ARTICLE_LIST;
              url += "$curPage/json";
              print("回调---$url");
              return url;
           },)),
           menuIcons(context, Icon(Icons.favorite, size: 48.0, color: Color(0xCCDD0857C)), 'Love' ,ArticleListPage(urlCallback: (curPage){
              String url = Api.COLLECT_LIST;
              url += "$curPage/json";
              print("回调---$url");
              return url;
           },)),
           menuIcons(context, Icon(FontAwesomeIcons.tree, size: 48.0, color: Color(0xCC00857C)), 'Tree' ,TreePage()),
           menuIcons(context, Icon(FontAwesomeIcons.addressCard, size: 48.0, color: Color(0xCC00857C)), 'WanApp' ,WanApp()),
        ],
      ),
    );
  }
  
}