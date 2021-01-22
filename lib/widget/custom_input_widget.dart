import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class CustomInputWidget extends StatefulWidget{
  String _title;
  String hint;
  CustomInputWidget(this._title,{Key key,this.hint});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomInputWidgetState();
  }
}

class CustomInputWidgetState extends State<CustomInputWidget> {
  //输入框控制器
  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
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
              top: ScreenUtil().setHeight(10),
              right: ScreenUtil().setWidth(64),
              left: ScreenUtil().setWidth(300),
              child: Container(
                  color: Colors.white,
                  width: ScreenUtil().setWidth(1000),
                  height: ScreenUtil().setHeight(144),
                  child: TextField(
                    autofocus: false,
                    textAlign: TextAlign.end,
                    controller: inputController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hint,
                      hintStyle: TextStyle(color: Color.fromRGBO(188,188,188,1))
                    ),
                  ),
              ),
          ),
        ],
      ),
    );
  }

}