import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/config/color_constant.dart';
import 'package:jwt/config/string_constant.dart';

// ignore: must_be_immutable
class CustomCheckBoxWidget extends StatefulWidget{
  bool isChecked = false;
  CustomCheckBoxWidget({@required this.isChecked});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCheckBoxWidgetState();
  }
}

class CustomCheckBoxWidgetState extends State<CustomCheckBoxWidget>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(320),
            height: ScreenUtil().setHeight(100),
            child: Text(
              StringConstant.INFO_PRECISE,
              style: TextStyle(
                  color: widget.isChecked ? ColorConstant.CUSTOM_INFO_CHECKED : ColorConstant.CUSTOM_INFO_UNCHECKED,
                  fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true)
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(width: 0.7,color: widget.isChecked ? ColorConstant.CUSTOM_INFO_CHECKED : ColorConstant.CUSTOM_INFO_UNCHECKED)
            ),
          ),
          Positioned(
            right: ScreenUtil().setWidth(0),
            bottom:  ScreenUtil().setHeight(0),
            child: Offstage(
                offstage: widget.isChecked,
                child:Image.asset(
                  "images/icon_select.png",
                  width: ScreenUtil().setWidth(46),
                  height: ScreenUtil().setHeight(46),
                  fit: BoxFit.cover,
                )
            ),
          )
        ],
      ),
      onTap:(){
        setState(() {
          widget.isChecked = !widget.isChecked;
        });
      },
    );
  }
}

