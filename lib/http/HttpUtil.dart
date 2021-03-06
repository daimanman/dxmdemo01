import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dxmdemo01/http/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUtil {
  static const String GET = "get";
  static const String POST = "post";

  static void get(String url,Function callback,{
    Map<String,String> params,
    Map<String,String> headers,
    Function errorCallback
  }) async {
    if(!url.startsWith("http")){
      url = Api.BaseUrl + url;
    }

    if(params != null && params.isNotEmpty){
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key,value){
        sb.write("${key}=${value}&");
      });

      String paramStr = sb.toString();
      paramStr = paramStr.substring(0,paramStr.length-1);
      url += paramStr;
      
    }
      print("get url $url");
      await _request(url, callback,
        method: GET,
        headers: headers,
        errorCallback: errorCallback
      );
  }


  static void post(String url,Function callback,
  {
    Map<String,String> params,
    Map<String,String> headers,
    Function errorCallback
  }
  ) async{
    if(!url.startsWith("http")){
      url = Api.BaseUrl+url;
    }
    await _request(url, callback,
      method: POST,
      headers: headers,
      params: params,
      errorCallback: errorCallback
    );
  }

  

  static Future _request(String url,Function callback,{
    String method,
    Map<String,String> headers,
    Map<String,String> params,
    Function errorCallback
  }) async {
    String errorMsg;
    int errorCode;
    var data;

    try{
      Map<String,String> headerMap = headers == null ? new Map() : headers;
      Map<String,String> paramMap = params == null ? new Map() : params;
      
      SharedPreferences sp = await SharedPreferences.getInstance();
      String cookie = sp.get("cookie");
      if(cookie != null && cookie.length > 0){
          headerMap["Cookie"] = cookie;
      }
      
      http.Response res;
      if(POST == method){
        print("POST:URL=$url");
        print("POST:BODY=${paramMap.toString()}");
        res  = await http.post(url,headers:headerMap,body:paramMap);
      }else{
        print("GET:URL=$url");
        res = await http.get(url,headers:headerMap);
      }

      if(res.statusCode != 200){
        errorMsg = "网络请求错误,状态码:${res.statusCode.toString()}";
        _handError(errorCallback, errorMsg);
        return;
      }

      Map<String,dynamic> map = json.decode(res.body);
      errorCode = map["errorCode"];
      errorMsg = map["errorMsg"];
      data = map["data"];


      if(url.contains(Api.LOGIN)){
        SharedPreferences sp = await SharedPreferences.getInstance();
        print("cookie=="+res.headers["set-cookie"]);
        sp.setString("cookie",res.headers["set-cookie"]);
      }

      //callback 返回 data 数据类型为 dynamic 
      //errorCallback 中为了方便 直接返回了String 类型的errorMsg

      if(callback != null && errorCode >= 0){
        callback(data);
      }
      
      if(errorCallback != null && errorCode < 0){
        _handError(errorCallback, errorMsg);
      }
      
    }catch(exception){
      _handError(errorCallback,exception.toString());
    }
  }

  static void _handError(Function errorCallback,String errorMsg){
    if(errorCallback != null){
      errorCallback(errorMsg);
    }
    print("errorMsg : $errorMsg");

  }
}