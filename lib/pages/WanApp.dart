import 'package:flutter/material.dart';
import 'package:dxmdemo01/constant/colors.dart';
import 'package:dxmdemo01/pages/HomeListPage.dart';
import 'package:dxmdemo01/pages/MyInfoPage.dart';
import 'package:dxmdemo01/pages/TreePage.dart';

class WanApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WanAppState();
  }
}

class WanAppState extends State<WanApp> with TickerProviderStateMixin {
  int _tabIndex = 0;
  List<BottomNavigationBarItem> _navigationViews;
  var appBarTitles = ["首页","发现","我的"];
  IndexedStack _body;
 final navigatorKey = GlobalKey<NavigatorState>();
  void initData(){
    _body = IndexedStack(
      children: <Widget>[
        HomeListPage(),TreePage(),MyInfoPage()
      ],
      index: _tabIndex,
    );
  }
  @override
  void initState(){
    super.initState();
    _navigationViews = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: Text(appBarTitles[0]),
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon:const Icon(Icons.widgets),
        title:Text(appBarTitles[1]),
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon:const Icon(Icons.person),
        title:Text(appBarTitles[2]),
        backgroundColor:Colors.blue,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    initData();
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme:ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
      ),
      home:Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitles[_tabIndex],
            style: TextStyle(color: Colors.blue),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                print("ok search");
              },
            ),
          ],
        ),
        body: _body,
        bottomNavigationBar: BottomNavigationBar(
          items: _navigationViews.map((BottomNavigationBarItem navigationView){
            return navigationView;
          }).toList(),
          currentIndex: _tabIndex,
          type:BottomNavigationBarType.fixed,
          onTap: (index){
            setState(() {
                    _tabIndex = index;       
           });
          },
        ),
      ),
    );

  }

}