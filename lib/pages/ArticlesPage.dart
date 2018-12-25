import 'package:flutter/material.dart';
import 'package:dxmdemo01/pages/ArticleListPage.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ArticlesPage extends StatefulWidget{
  var data;
  ArticlesPage(this.data);
  @override
  State<StatefulWidget> createState() {
    return ArticlesPageState();
  }
}

class ArticlesPageState extends State<ArticlesPage> with SingleTickerProviderStateMixin {
 
  TabController _tabContro;
  List<Tab> tabs = List();
  List<dynamic> list;
  @override
  void initState(){
    super.initState();
    list =  widget.data['children'];
    for(var value in list){
      tabs.add(Tab(text: value['name'],));
    }
    _tabContro = TabController(length: list.length,vsync: this);
  }
  @override
  void dispose(){
    _tabContro.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.data['name']),
      ),
      body:Scaffold(
          appBar: TabBar(
            isScrollable: true,
            controller: _tabContro,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.black,
            indicatorColor: Theme.of(context).accentColor,
            tabs:tabs,
          ),
          body: TabBarView(
            controller: _tabContro,
            children:list.map((dynamic itemData){
              print('${itemData["id"]}---');
                return ArticleListPage(cid: '${itemData["id"]}',);
            }).toList(),
          ),
        ),
    );
  }

}