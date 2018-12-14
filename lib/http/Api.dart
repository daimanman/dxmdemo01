class Api{
  static const String BaseUrl = "http://wwww.wanandroid.com/";
  

  //首页banner
  static const String BANNER = "banner/json";


  //文章列表
  static const String ARTICLE_LIST = "article/list/";

  //收藏
  static const String COLLECT_LIST = "lg/collect/list/";

 
  static const ARTICLE_QUERY = "article/query/";

 
  static const String COLLECT = "lg/collect/";

  static const String UNCOLLECT_ORIGINID = "lg/uncollect_originId";

  static const String  UNCOLLECT_LIST =  "lg/uncollect/";

  //login register
  static const String  LOGIN = "user/login";

  static const String REGISTER = "user/register";

  
  static const String TREE = "tree/json";


  static const String FRIEND = "friend/json";

 
  static const String HOTKEY = "hotkey/json";
}

class WandAndroidResp{

  int errorCode;

  String errorMsg;

  String data;
}