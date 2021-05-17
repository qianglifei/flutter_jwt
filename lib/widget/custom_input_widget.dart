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
      width: ScreenUtil().uiSize.width,
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(144),
        maxHeight: ScreenUtil().setHeight(500),
      ),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(64)),
              child: Text(widget._title,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1))),
          ),
          Expanded(
            child: Text(""),
          ),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
              constraints: BoxConstraints(
                maxHeight: ScreenUtil().setHeight(500),
                minHeight: ScreenUtil().setHeight(144),
                maxWidth: ScreenUtil().setHeight(680)
              ),
              padding:EdgeInsets.only(left:20.0, right:10.0, top:15.0, bottom:4.0),
              child: TextField(
                textAlign: TextAlign.right,
                controller: inputController,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                decoration: InputDecoration.collapsed(
                  hintText: widget.hint,
                  hintStyle: TextStyle(color: Color.fromRGBO(188,188,188,1))
                ),
                maxLines: null,
                //发生改变时赋值
                onChanged: (val){
                    widget.content = val;
                    if(widget.content != null && "" != widget.content){
                      widget.callBack(widget.content);
                    }
                },
              ),
          ),
        ],
      ),
    );
  }

}