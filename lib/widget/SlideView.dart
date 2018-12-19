import 'package:flutter/material.dart';
import 'package:dxmdemo01/pages/ArticleDetailPage.dart';


class SlideView extends StatefulWidget{
  var data;
  SlideView(this.data);

  @override
  State<StatefulWidget> createState() {
    return SlideViewState(data);
  }
}
class SlideViewState extends State<SlideView> with SingleTickerProviderStateMixin{
  List data;
  TabController tabController;
  SlideViewState(this.data);

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: data != null ? data.length : 0 ,vsync: this);
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     List<Widget> items = [];
     if(data != null && data.length > 0){
       for(var i = 0; i < data.length ;i++){
         var item = data[i];
         var imgUrl = item["imagePath"];
         var title = item["title"];
         item["link"] = item["url"];
         items.add(
            GestureDetector(
              onTap: (){
                  _handOnItemClick(item);
              },
              child: AspectRatio(
                aspectRatio: 2.0/1.0,
                child: Stack(
                  children: <Widget>[
                    Image.network(imgUrl,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        width: 1000.0,
                        color: const Color(0x50000000),
                        padding: const EdgeInsets.all(7.0),
                        child: Text(title,style: TextStyle(color:Colors.white,fontSize:15.0,decoration: TextDecoration.none),),
                       
                      ),
                   )
                  ],
                ),
              ),
            )
         );
       }
     }
     return TabBarView(
        controller:tabController,
        children: items,
      );
  }


  void _handOnItemClick(itemData){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return ArticleDetailPage(title: itemData["title"],url: itemData["link"],);
        }
      )
    );
  }

  

}

