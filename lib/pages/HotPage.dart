import 'package:flutter/material.dart';
import 'package:dxmdemo01/http/Api.dart';
import 'package:dxmdemo01/http/HttpUtil.dart';
import 'package:dxmdemo01/pages/ArticleDetailPage.dart';
import 'package:dxmdemo01/pages/SearchPage.dart';
class HotPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return HotPageState();
  }

}

class HotPageState extends State<HotPage>{
  List<Widget> hotkeyWidgets = List();
  List<Widget> friendWidgets = List();
  void _getFriend(){
    HttpUtil.get(Api.FRIEND,(data){
        setState(() {
          List datas = data;
          friendWidgets.clear();
          for(var itemData in datas){
              Widget actionChip = ActionChip(
                backgroundColor: Theme.of(context).accentColor??Colors.white12,
                label: Text(itemData['name']??'--',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  itemData['title'] = itemData['name']??'--';
                  Navigator.of(context).push(MaterialPageRoute(builder:(context){
                      return ArticleDetailPage(
                        title: itemData['title'],
                        url:itemData['link'],
                      );
                  }));
                },
              );
              friendWidgets.add(actionChip);
          }          
        });
    });
  }
  void _getHotKey(){
    HttpUtil.get(Api.HOTKEY,(data){
      setState(() {
            List datas = data;
            hotkeyWidgets.clear();
            for(var value in datas){
              Widget actionChip = ActionChip(
                backgroundColor: Theme.of(context).accentColor??Colors.white24,
                label: Text(value['name']??'--',style:TextStyle(color:Colors.white)),
                onPressed: (){
                   Navigator
                    .of(context)
                    .pushReplacement(new MaterialPageRoute(builder: (context) {
                    return new SearchPage(value['name']);
                }));
                },
              );
              hotkeyWidgets.add(actionChip);
            }  
      });
    });
  }
  @override
  void initState(){
    super.initState();
    print("init start -------");
    _getFriend();
    _getHotKey();
  }
  @override
  Widget build(BuildContext context) {
    print("create start -------");
    return  ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('大家都在搜',style: TextStyle(color: Theme.of(context).accentColor??Colors.blue,fontSize:20.0,decoration: TextDecoration.none ),),
        ),
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children:hotkeyWidgets,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('常用网站',style:TextStyle(color: Theme.of(context).accentColor??Colors.blue,fontSize: 20.0,decoration: TextDecoration.none)),
        ),
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children:friendWidgets,
        ),
      ],
    );
  }
}

class HotPageDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('hot'),
     ),
     body: HotPage(),
   );
  }

}
