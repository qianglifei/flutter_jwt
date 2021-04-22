import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/config/color_constant.dart';
import 'package:jwt/config/string_constant.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_checkbox_widget.dart';

class CustomCheckBoxLayout extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCheckBoxWidgetLayoutState();
  }
}

class CustomCheckBoxWidgetLayoutState extends State<CustomCheckBoxLayout>{
   TextEditingController _remarkTextController = new  TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
         margin: EdgeInsets.only(left: ScreenUtil().setWidth(100),top: ScreenUtil().setHeight(32),bottom: ScreenUtil().setHeight(32)),
         child: Text("核准程度",style: TextStyle(
                fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
                color: ColorConstant.TEXT_COLOR_GRAY
            )
         ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCheckBoxWidget(
                isChecked: false
            ),
            CustomCheckBoxWidget(
                isChecked: false
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(100),top: ScreenUtil().setHeight(32),bottom: ScreenUtil().setHeight(32)),
          child: Text("备注",style: TextStyle(
              fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
              color: ColorConstant.TEXT_COLOR_GRAY
          )
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(245),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(width: ScreenUtil().setWidth(1))
          ),
          margin: EdgeInsets.only(right :  ScreenUtil().setWidth(100),left: ScreenUtil().setWidth(100),bottom: ScreenUtil().setHeight(32)),
          child: TextField(
            controller: _remarkTextController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            autofocus: true,
            decoration: InputDecoration.collapsed(

            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                ScreenUtil().setWidth(386),
                ScreenUtil().setHeight(120),
                Colors.white,
                Colors.blue,
                "取消",
                (){
                  Navigator.of(context).pop();

                },
                marginTop: ScreenUtil().setHeight(40),
            ),
            CustomButton(
                ScreenUtil().setWidth(386),
                ScreenUtil().setHeight(120),
                Colors.blue,
                Colors.white,
                "提交",
                (){
                    Navigator.of(context).pop();
                },
               marginTop: ScreenUtil().setHeight(40),
            ),
          ],
        )
      ],
    );
  }
}

