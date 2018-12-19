import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleDetailPage extends StatefulWidget{

  String title;
  String url;

  ArticleDetailPage({Key key,this.title,this.url}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleDetailPageState();
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage>{
  bool isLoad = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState(){
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state){
      debugPrint('state:_'+state.type.toString());
      
      if(state.type == WebViewState.finishLoad){
        setState(() {
                  isLoad = false;
        });
      }

      if(state.type == WebViewState.startLoad){
        setState(() {
                  isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: isLoad?LinearProgressIndicator() : Divider(
            height: 1.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      withZoom: false,
      withLocalStorage:true,
      withJavascript: true,
    );
  }

}