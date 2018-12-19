import 'package:flutter/material.dart';
import 'package:dxmdemo01/constant/Constants.dart';
import 'package:dxmdemo01/event/LoginEvent.dart';
import 'package:dxmdemo01/http/Api.dart';
import 'package:dxmdemo01/http/HttpUtil.dart';
import 'package:dxmdemo01/util/DataUtils .dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() {
    return new LoginPageState();
  }

}

class LoginPageState extends State<LoginPage>{
  TextEditingController _nameContro =new TextEditingController(
    text: 'daimanman'
  );
  TextEditingController _passwordContro = new TextEditingController(
    text: '411523manxiao'
  );
  GlobalKey<ScaffoldState> scaffoldKey ;

  @override
  void initState(){
    super.initState();
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  @override
  Widget build(BuildContext context) {
    Row avatar = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.account_circle,
          color:Theme.of(context).accentColor,
          size:80.0
        )
      ],
    );

    TextField name = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
        labelText: '用户名'
      ),
      controller: _nameContro,
    );

    TextField password = new TextField(
      decoration: InputDecoration(labelText: '密码'),
      obscureText: true,
      controller: _passwordContro,
    );


    Row loginAndRegister = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new RaisedButton(
          child: new Text(
            '登录',
            style: new TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).accentColor,
          disabledColor: Colors.blue,
          textColor: Colors.white ,
          onPressed: (){
            //TODO login
            _login();
          },
        ),
        new RaisedButton(
          child: Text(
            '注册',
            style: TextStyle(color:Colors.white),
          ),
          color: Colors.blue,
          disabledColor: Colors.blue,
          textColor: Colors.white,
          onPressed: (){

          },

        ),
      ],
    );


    return new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40.0,10.0,40.0, 0.0),
          child: ListView(
            children: <Widget>[
              avatar,
              name,
              password,
              Padding(
                padding: EdgeInsets.fromLTRB(40.0,10.0,40.0,0.0),
              ),
              loginAndRegister
            ],
          ),
        ),
    );
  }


  void _login (){
    String name = _nameContro.text;
    String password = _passwordContro.text;
    if(name.length == 0){
      _showMessage('请输入姓名');
      return;
    }

    if(password.length == 0){
      _showMessage('请输入密码');
      return;
    }

    Map<String,String> map = new Map();
    map['username'] = name;
    map['password'] = password;

    HttpUtil.post(
      Api.LOGIN,
      (data) async {
        print("login info $data");
        DataUtils.saveLoginInfo(name).then((r){
          Constants.eventBus.fire(new LoginEvent());
          Navigator.of(context).pop();
        });
      },
      params: map,
      errorCallback: (msg){
        _showMessage(msg);
      }
    );
  }

  void _showMessage(String msg){
    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(msg))
    );
  }

  

}