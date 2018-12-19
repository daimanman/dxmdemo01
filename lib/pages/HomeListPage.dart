import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dxmdemo01/constant/Constants.dart';
import 'package:dxmdemo01/http/Api.dart';
import 'package:dxmdemo01/http/HttpUtil.dart';
import 'package:dxmdemo01/item/ArticleItem.dart';
import 'package:dxmdemo01/widget/EndLine.dart';
import 'package:dxmdemo01/widget/SlideView.dart';


class HomeListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage>{
  List listData = List();
  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;
  ScrollController _controller = ScrollController();
  TextStyle titleTextStyle = TextStyle(fontSize:15.0);
  TextStyle subtitleTextStyle = TextStyle(fontSize: 12.0,color:Colors.blue);
  SlideView _bannerView;

   @override
  void initState(){
    super.initState();
    getBanner();
    getHomeArticlelist();

  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if(listData ==  null ){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    Widget listView = ListView.builder(
      itemCount: listData.length+1,
      itemBuilder: (context,index ) => buileItem(index),
      controller: _controller,
    );

    return RefreshIndicator(child: listView,onRefresh: _pullToRefresh,);

  }

  HomeListPageState(){
    _controller.addListener((){
      print('scroll controller listener');
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      print("maxScroll = $maxScroll pixels=$pixels");
      if(maxScroll == pixels && listData.length < listTotalSize){
        getHomeArticlelist();
      }
    });
  }


  

 

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getBanner();
    getHomeArticlelist();
    return null;
  }

  void getBanner(){
    String bannerUrl = Api.BANNER;
    HttpUtil.get(bannerUrl,(data){
      if(data != null){
        setState(() {
                    bannerData = data;
                    _bannerView = SlideView(bannerData);
                });
      }
    });
  }

  void getHomeArticlelist(){
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";
    print("====当前页 $curPage");
    HttpUtil.get(url,(data){
        if(data == null){
          return;
        }
        Map<String,dynamic> map = data;
        var _listData = map['datas'];
        listTotalSize = map['total'];
        setState(() {
                List list1 = List();
                if(curPage == 0){
                  listData.clear();
                }
                curPage++;
                print("+当前页 $curPage");
                list1.addAll(listData);
                list1.addAll(_listData);
                if(list1.length >= listTotalSize){
                  list1.add(Constants.END_LINE_TAG);
                }
                listData = list1;  
        });
    },errorCallback:(msg){
        print("请求文章列表错误");
    });
  }

  Widget buileItem(int i){
    if(i == 0){
      return Container(
        height: 180.0,
        child: _bannerView,
      );
    }
    i -= 1;
    var itemData = listData[i];
    if(itemData is String && itemData == Constants.END_LINE_TAG){
      return EndLine();
    }
    return ArticleItem(itemData);
  }



}
