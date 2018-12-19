import 'package:flutter/material.dart';
import 'package:dxmdemo01/pages/ArticleDetailPage.dart';

class AboutUsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AboutUsPageState();
  }

}

class AboutUsPageState extends State<AboutUsPage>{

  @override
  Widget build(BuildContext context) {
    Widget icon = new Image.asset('assets/ic_launcher_round.png',width: 100.0,height: 100.0);

    return new Scaffold(
      appBar: AppBar(
        title: Text('关于我们'),
      ),
      body: ListView(
        padding:EdgeInsets.fromLTRB(0.0, 10.0,0.0,0.0),
        children: <Widget>[
          icon,
          createListTile('关于项目','这是我的demo项目,模仿WanAndroid 客户端,实现了大部分的功能效果,首页抽屉效果不习惯就嘿嘿嘿了','https://github.com/canhuah/WanAndroid', 'Dxm git', context),
          createListTile('关于我','一只程序dog 博客地址', 'Dxm Blog','https://me.csdn.net/aqqabqqb', context),
        ],
      ),
    );
  }

  ListTile createListTile(String title,String subtitle,String url,String navTitle,BuildContext context){
    return ListTile(
      title:  Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right,color: Theme.of(context).accentColor),
      onTap: (){
        goUrl(url, navTitle, context);
      },
    );
  }

  void goUrl(String url,String title,BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context){
        return ArticleDetailPage(title: title,url: url,);
      }
    ));
  }

}