import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';

typedef CallBack = void Function(String value);
// ignore: must_be_immutable
class CustomInputWidget extends StatefulWidget{
  String _title;
  String content= "";
  String hint;
  CallBack callBack;
  CustomInputWidget(this._title,{Key key,this.hint,this.content,this.callBack});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomInputWidgetState();
  }
}

class CustomInputWidgetState extends State<CustomInputWidget> {
  //输入框控制器
  TextEditingController inputController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputController = TextEditingController();
    inputController.addListener(() { });
    inputController.text = widget.content;
  }
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
              top: ScreenUtil().setHeight(56),
              right: ScreenUtil().setWidth(64),
              left: ScreenUtil().setWidth(300),
              child: Container(
                  color: Colors.white,
                  width: ScreenUtil().setWidth(1000),
                  height: ScreenUtil().setHeight(144),
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: inputController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hint,
                      hintStyle: TextStyle(color: Color.fromRGBO(188,188,188,1))
                    ),
                    //发生改变时赋值
                    onChanged: (val){
                        widget.content = val;
                        if(widget.content != null && "" != widget.content){
                          widget.callBack(widget.content);
                        }
                    },
                  ),
              ),
          ),
        ],
      ),
    );
  }

}