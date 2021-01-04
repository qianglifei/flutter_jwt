import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/screenutil.dart';
// ignore: must_be_immutable
class BaseTitleAppBar extends StatelessWidget{
  String title;
  String leftIconUrl;
  String rightIconUrl;
  String rightText;
  bool isShowLeftBackIcon;
  bool isShowRightWidget;
  final VoidCallback rightClick;

  BaseTitleAppBar(this.title,{
      this.isShowLeftBackIcon = true,
      this.isShowRightWidget = true,
      this.leftIconUrl = "images/button_back.png",
      this.rightIconUrl = "images/icon_menu.png",
      this.rightText,
      this.rightClick
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 12),
            child: Offstage(
              offstage: !isShowLeftBackIcon,
              child:Image.asset(
                leftIconUrl,
                width: ScreenUtil().setWidth(28),
                height: ScreenUtil().setHeight(50),
                fit: BoxFit.fill,
                ),
              )
        ),
        Text(
            title,
            style: TextStyle(fontSize: ScreenUtil().setSp(52,allowFontScalingSelf: true),color: Colors.white)
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Offstage(
            offstage: !isShowRightWidget,
            child: Image.asset(
              rightIconUrl,
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(40),
              fit: BoxFit.cover,
            ),
          )
        ),
      ],
    );
  }

}

