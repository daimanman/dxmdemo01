class Api{
  static const String BaseUrl = "http://www.wanandroid.com/";
  

  
  static const String BANNER = "banner/json";


  
  static const String ARTICLE_LIST = "article/list/";

  
  static const String COLLECT_LIST = "lg/collect/list/";

 
  static const ARTICLE_QUERY = "article/query/";

 
  static const String COLLECT = "lg/collect/";

  static const String UNCOLLECT_ORIGINID = "lg/uncollect_originId/";

  static const String  UNCOLLECT_LIST =  "lg/uncollect/";

  
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