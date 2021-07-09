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
    return Container(
      height: ScreenUtil().setHeight(150),
      decoration: BoxDecoration(
        color: Color.fromRGBO(52,135,215,1)
      ),
      child: Row(
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
                child: _buildImageButton("images/icon_dwgl.png")
              )
          ),
        ],
      ),
    );
  }

  Widget _buildImageButton(String urlIcon){
    return GestureDetector(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Image.asset(
              urlIcon,
              width: ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(40),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text("队伍选择",
                  style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color.fromRGBO(255, 255, 255, 1)))
          ),
        ],
      ),
      onTap: (){
        if(rightClick != null){
            rightClick();
        }
      },
    );
  }
}

