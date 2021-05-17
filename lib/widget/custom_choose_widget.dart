import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'custom_alert_dialog.dart';


///typedef 给某一种特定的函数类型起一个名字，可以类比class和对象
///这样理解，自己定义了一种数据类型，不过这种数据类型 是函数类型
///一个一个的具体实现的函数就相当于按照这种类型实力话对象会有类型检查
///typedef ValveChanged<T> = void Function(T value)
typedef _CallBack = void Function(String value,{String remark});
// ignore: must_be_immutable
class CustomChooseWidget extends StatefulWidget{
  String _title;
  _CallBack callBack;
  CustomChooseWidget(this._title,{Key key,this.callBack}) : assert( _title != null);
  @override
  State<StatefulWidget> createState() => CustomChooseWidgetState();
}

class CustomChooseWidgetState extends State<CustomChooseWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  InkWell(
      child: Container(
        height: ScreenUtil().setHeight(144),
        width: ScreenUtil().uiSize.width,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: ScreenUtil().setHeight(47),
                left: ScreenUtil().setWidth(64),
                child: Text(widget._title,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
            ),
            Positioned(
                top: ScreenUtil().setHeight(30),
                right: ScreenUtil().setWidth(100),
                child: Text(widget._title,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
            ),
            Positioned(
                top: ScreenUtil().setHeight(50),
                right: ScreenUtil().setWidth(64),
                child: Image.asset(
                  "images/icon_more.png",
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(36),
                  fit: BoxFit.cover,
                )
            ),
          ],
        ),
      ),
      onTap: (){
        popDialog(context, ShowAlertDialog(title: "核准程度",content: "sdf",items: ["取消","确认"],));
      },
    );
  }

  static void popDialog(BuildContext context, Widget widget) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return widget;
      });
  }
}