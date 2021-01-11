import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
typedef _CallBack = void Function();
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
        setState(() {
            if(widget._title != null && widget.callBack != null){
                widget.callBack();
            }
        });
      },
    );
  }
}