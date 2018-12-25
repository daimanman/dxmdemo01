import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dxmdemo01/constant/Constants.dart';
import 'package:dxmdemo01/http/Api.dart';
import 'package:dxmdemo01/http/HttpUtil.dart';
import 'package:dxmdemo01/item/ArticleItem.dart';
import 'package:dxmdemo01/widget/EndLine.dart';
import 'package:dxmdemo01/widget/SlideView.dart';

class ArticleListPage extends StatefulWidget{
  String url;
  String method;
  Function urlCallback;
  String cid;
  ArticleListPage({this.url,this.method,this.urlCallback,this.cid});
  @override
  State<StatefulWidget> createState() {
    return ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage>{

  List listData = List();
  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;
  ScrollController _controller = ScrollController();
  TextStyle titleTextStyle = TextStyle(fontSize:15.0);
  TextStyle subtitleTextStyle = TextStyle(fontSize: 12.0,color:Colors.blue);
  SlideView _bannerView;
  Map<String,String> map = new Map();

   @override
  void initState(){
    super.initState();
    getArticlelist();
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
      itemCount: listData.length,
      itemBuilder: (context,index ) => buileItem(index),
      controller: _controller,
    );

    return RefreshIndicator(child: listView,onRefresh: _pullToRefresh,);

  }

  ArticleListPageState(){
    _controller.addListener((){
      print('scroll controller listener');
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      print("maxScroll = $maxScroll pixels=$pixels");
      if(maxScroll == pixels && listData.length < listTotalSize){
        getArticlelist();
      }
    });
  }


  

 

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getArticlelist();
    return null;
  }

  

  void getArticlelist(){
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";
    map["cid"] = widget.cid;
    print("====当前页 $curPage");
    if(null != widget.urlCallback){
      url = widget.urlCallback(curPage);
    }
    print(url);
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
    },params: map);
  }

  Widget buileItem(int i){
    // if(i == 0){
    //   return Container(
    //     height: 180.0,
    //     child: _bannerView,
    //   );
    // }
    // i -= 1;
    var itemData = listData[i];
    if(itemData is String && itemData == Constants.END_LINE_TAG){
      return EndLine(msg:"真的没有了");
    }
    return ArticleItem(itemData);
  }
}
