import 'package:flutter/material.dart';
import 'package:dxmdemo01/http/HttpUtil.dart';

class Dxm1Page extends StatefulWidget{

  @override
  Dxm1PageState createState(){
    return Dxm1PageState();
  }
  
}

class Dxm1PageState extends State<Dxm1Page>{
  int _count = 1;

  List<String> items = <String>[
    "Hello World"
  ];

  @override
  Widget build(BuildContext context) {
    var length = items?.length ?? 0;
    return new Scaffold(
      appBar: AppBar(
        title: Text('Dxm 1'),
      ),
      body:ListView.builder(
       itemBuilder: (BuildContext context,int index){
         if(index >= length){
           return null;
         }

          print('index is $index');
         var title = items[index];
         return new Container(
           decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(color: Colors.grey.shade300)
              )
            ),
           child: new ListTile(
             key: new ValueKey<String>(title),
             title: Text(title),
           ),
         );

       },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),title:Text('GPS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),title: Text('用户中心'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backup),title: Text('BK'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'click FAB',
        onPressed: (){
          setState(() {
                _count++;  
                items.add("add $_count");     
          });
        },
      ),
    );
  }

}


