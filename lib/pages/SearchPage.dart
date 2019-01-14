import 'package:flutter/material.dart';
import 'package:dxmdemo01/pages/HotPage.dart';
import 'package:dxmdemo01/pages/ArticleListPage.dart';
import 'package:dxmdemo01/http/Api.dart';

class SearchPage extends StatefulWidget{
  String searchKey;
  SearchPage(this.searchKey);
  @override
  State<StatefulWidget> createState() {
    return SearchPageState(searchKey);
  }
}

class SearchPageState extends State<SearchPage>{
  TextEditingController _searchController;
  ArticleListPage _searchListPage;
  String searchStr;
  SearchPageState(this.searchStr);
  @override
  void initState(){
    super.initState();
    _searchController = TextEditingController(text: searchStr??'');
    changeContent();
  }
  void changeContent(){
    setState(() {
      print("search text _searchController.text=${_searchController.text}");
      var text = _searchController.text;
          _searchListPage = ArticleListPage.fromKey(new ValueKey(text), searchKey:_searchController.text,method: 'POST',urlCallback: (int curPage){
            String url = Api.ARTICLE_QUERY;
              url += "$curPage/json";
              print("search 回调---$url");
              return url;
          },);
        });
  }
  Widget _getBody(){
    return (_searchController.text == null ||_searchController.text.isEmpty) ?
    Center(
      child: HotPage(),
    ):_searchListPage;
  }
  @override
  Widget build(BuildContext context) {
   TextField searchField = TextField(
     autofocus: true,
     decoration: InputDecoration(
       border: InputBorder.none,
       hintText: '搜索关键词',
     ),
     controller: _searchController,
   );
   return Scaffold(
     appBar: AppBar(
       title: searchField,
       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.search),
           onPressed: (){
             changeContent();
           },
         ),
         IconButton(
           icon: Icon(Icons.close),
           onPressed: (){
             setState(() {
                _searchController.clear();            
             });
           },
         )
       ],
     ),
     body: _getBody(),
   );
  }

}