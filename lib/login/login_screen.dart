import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/http/common_service.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/main/app.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/progress_dialog.dart';

// ignore: must_be_immutable
class LoginScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return LoginScreenState();
  }
}

class LoginScreenState extends BaseWidgetState<LoginScreen> {
  bool check = false;
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //设置AppBar不可见
    setAppBarVisible(false);
  }

  @override
  CustomAppBar getAppBar() {
    return CustomAppBar(
      child: Container(
        child: BaseTitleAppBar(
            "欢迎登录",
            isShowLeftBackIcon: false,
            isShowRightWidget: false
        ),
      )
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Container(
      width: ScreenUtil.defaultSize.width,
      height: ScreenUtil.defaultSize.height,
      child: Stack(
        children: <Widget>[
          Image.asset(
            "images/icon_login_background.png",
            width: ScreenUtil.defaultSize.width,
            height: ScreenUtil().setHeight(336),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: ScreenUtil().setHeight(231),
            left: ScreenUtil().setWidth(435),
            child: Image.asset(
              "images/icon_login.png",
              width:  ScreenUtil().setWidth(210),
              height: ScreenUtil().setHeight(210),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: ScreenUtil().setHeight(617),
              left: ScreenUtil().setWidth(96),
              child: Container(
                width: ScreenUtil().setWidth(888),
                height: ScreenUtil().setHeight(144),
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(242, 244, 245, 1),
                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72))),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(64)),
                        child: Image.asset(
                          "images/icon_yhm.png",
                          width: ScreenUtil().setWidth(64),
                          height: ScreenUtil().setHeight(64),
                          fit: BoxFit.fill,
                        ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(650),
                      child: TextField(
                          autofocus: false,
                          controller: phoneController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                            labelText: '请输入用户名',
                          )),
                    )
                  ],
                ),
              )
          ),
          Positioned(
              top: ScreenUtil().setHeight(809),
              left: ScreenUtil().setWidth(96),
              child: Container(
                width: ScreenUtil().setWidth(888),
                height: ScreenUtil().setHeight(144),
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(242, 244, 245, 1),
                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72))),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(64)),
                      child: Image.asset(
                        "images/icon_mima.png",
                        width: ScreenUtil().setWidth(64),
                        height: ScreenUtil().setHeight(64),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(650),
                      child: TextField(
                          autofocus: false,
                          controller: passController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                            labelText: '请输入密码',
                          ), obscureText: true),
                    )
                  ],
                ),
              )
          ),
          Positioned(
            top: ScreenUtil().setHeight(1001),
            left: ScreenUtil().setWidth(160),
              child: Container(
                width: ScreenUtil().setWidth(888),
                height: ScreenUtil().setHeight(60),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Checkbox(
                            value: this.check,
                            activeColor: Colors.green,
                            onChanged: (bool vars){
                              setState(() {
                                this.check = !this.check;
                              });
                            }
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(0),top: 0),
                        child: Text("记住密码",style: TextStyle(fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(350)),
                      child: Text("UUID",style: TextStyle(fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true))),
                    ),
                  ],
                ),
              )
          ),
          Positioned(
              top: ScreenUtil().setHeight(1273),
              left: ScreenUtil().setWidth(96),
              child: new MaterialButton(
                minWidth: ScreenUtil().setWidth(888),
                height: ScreenUtil().setHeight(144),
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: new Text('登录',style: TextStyle(fontSize: ScreenUtil().setSp(56,allowFontScalingSelf: true))),
                onPressed: () {

                  buildShowDialog(context);
                  Map<String,dynamic> requestBody = new Map();
                  requestBody.addAll({
                    "user_name":"1142103000-g2",
                    "user_password":"123456",
                    "imsi":"1edf2c3125ac5b6c",
                    "version":"1.0.9"
                  });
                  DioUtils.instance.postHttp<LoginResponseEntity>(
                      url: URLConfig.LOGIN ,
                      method: DioUtils.POST,
                      parameters:requestBody ,
                      onSuccess: (data){
                        //dialog 消息消失
                        Navigator.of(context).pop();

//                        Fluttertoast.showToast(
//                            msg: "登录成功",
//                            toastLength: Toast.LENGTH_SHORT,
//                            gravity: ToastGravity.CENTER,
//                            timeInSecForIosWeb: 1,
//                            backgroundColor: Colors.red,
//                            textColor: Colors.white,
//                            fontSize: 16.0
//                        );

                        print(data.toJson());
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return App();
                        }));
                      },
                      onError: (error){
                        Navigator.of(context).pop();
                        print("---error");
                      });
                },
              )
          )
        ],
      )
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }


  buildShowDialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return  Center(
              child: Container(
                padding:const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  //黑色背景
                    color: Colors.black87,
                    //圆角边框
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  //控件里面内容主轴负轴剧中显示
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //主轴高度最小
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                            '加载中...',
                            style: TextStyle(fontSize:15,color: Colors.white,decoration: TextDecoration.none,)
                        )
                      )
                    ]
                )));
        });
  }
  void _textFieldUserNameChanged(String value) {

  }

  void _textFieldPasswordChanged(String value) {

  }
}