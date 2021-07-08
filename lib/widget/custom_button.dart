import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef _CallBack = void Function();
// ignore: must_be_immutable
class CustomButton extends StatefulWidget{
  double width;
  double height;
  double radius;
  Color colors;
  Color textColor;

  String contentText;

  double marginBottom;
  double marginTop;
  final _CallBack callBack;

  CustomButton(this.width,this.height, this.colors,this.textColor,this.contentText,this.callBack,{this.marginBottom = 0,this.marginTop = 0}) :
  assert(width != null),
  assert(height != null),
  assert(colors != null),
  assert(textColor != null);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomButtonState();
  }

}

class CustomButtonState extends State<CustomButton>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.only(bottom: widget.marginBottom,top: widget.marginTop),
      child: InkWell(
          child: Container(
            child: Center(
              child: Text(widget.contentText,style:TextStyle(fontSize: ScreenUtil().setSp(48),color: widget.textColor)),
            ),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.colors,
              borderRadius: BorderRadius.all(Radius.circular(widget.height / 2)),
              border: Border.all(width: 1,color: Color.fromRGBO(52,135,215,1)),
            ),
          ),
          onTap: (){
            setState(() {
              widget.callBack();
            });
          },
      ),
    );
  }

}