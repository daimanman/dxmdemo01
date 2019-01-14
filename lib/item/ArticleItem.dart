import 'package:flutter/material.dart';
import 'package:dxmdemo01/http/Api.dart';
import 'package:dxmdemo01/http/HttpUtil.dart';
import 'package:dxmdemo01/pages/ArticleDetailPage.dart';
import 'package:dxmdemo01/pages/LoginPage.dart';
import 'package:dxmdemo01/util/DataUtils .dart';
import 'package:dxmdemo01/util/StringUtils.dart';

class ArticleItem extends StatefulWidget{
  var itemData;
  bool isSearch;
  String id;
  ArticleItem(var itemData){
    this.itemData = itemData;
    this.isSearch = false;
  }
  ArticleItem.isFromSearch(var itemData,String id){
    this.id = id;
    this.isSearch = true;
    this.itemData = itemData;
  }
  @override
  State<StatefulWidget> createState() {
    return ArticleItemState();
  }

}


class ArticleItemState extends State<ArticleItem>{

  void _handleOnItemCollect(itemData){
    DataUtils.isLogin().then((isLogin){
      if(!isLogin){
        _login();
      }else{
        _itemCollect(itemData);
      }
    });
  }
  void _login(){
    Navigator.of(context).push(MaterialPageRoute(builder:
      (context){
        return LoginPage();
      }
    ));
  }
  void _itemClick(itemData) async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context){
            return ArticleDetailPage(title: itemData['title'],url:itemData['link']);
          }
        )
      );
  }
  void _itemCollect(itemData){
    String url ;
    if(itemData['collect']??true){
      url = Api.UNCOLLECT_ORIGINID;
    }else{
      url = Api.COLLECT;
    }
    url += '${itemData["id"]}/json';
    HttpUtil.post(url,(data){
      setState(() {
              itemData["collect"] = !itemData["collect"];
            });
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isCollect = widget.itemData["collect"]??true;
    Row row1 = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Text('作者'),
              Text(
                widget.itemData["author"],
                style: TextStyle(color: Theme.of(context).accentColor),
              )
            ],
          ),
        ),
        Text(widget.itemData["niceDate"])
      ],
    );

    Row title = Row(
      children: <Widget>[
        Expanded(
          child: Text.rich(
            widget.itemData['isSearch']??false ? StringUtils.getTextSpan(widget.itemData["title"],'${widget.itemData["id"]}') : TextSpan(text:widget.itemData['title']),
            softWrap: true,
            style:TextStyle(fontSize:16.0,color:Colors.black),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Row charterName = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.isSearch ? false : widget.itemData['chapterName'],
            softWrap: true,
            style:TextStyle(color: Theme.of(context).accentColor),
            textAlign: TextAlign.left,
          ),
        ),
        GestureDetector(
          child: Icon(
            isCollect ? Icons.favorite : Icons.favorite_border,
            color: isCollect ? Colors.red : null,
          ),
          onTap: (){
            _handleOnItemCollect(widget.itemData);
          },
        )
      ],
    );

    Column column = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: row1,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0,10.0,5.0),
          child: title,
        ),
        Padding(
          padding:EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: charterName,
        ),
      ],
    );

    return Card(
      elevation: 4.0,
      child: InkWell(
        child: column,
        onTap: (){
          _itemClick(widget.itemData);
        },
      ),
    );

  }

}