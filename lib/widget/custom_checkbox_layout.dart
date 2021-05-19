import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/config/color_constant.dart';
import 'package:jwt/config/string_constant.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_checkbox_widget.dart';

typedef Callback = void Function(String value,String remark);
// ignore: must_be_immutable
class CustomCheckBoxLayout extends StatefulWidget{

  Callback callback;

  CustomCheckBoxLayout({this.callback});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCheckBoxWidgetLayoutState();
  }
}

class CustomCheckBoxWidgetLayoutState extends State<CustomCheckBoxLayout>{
   TextEditingController _remarkTextController = new  TextEditingController();
   bool isChecked = true ;
   bool isCheckeds = true ;
   String _hzcd = "";
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
                StringConstant.INFO_PRECISE,
                isChecked: isChecked,
                callback: (isChecked){
                  setState(() {
                    this.isChecked = !isChecked;
                    if(this.isChecked){
                      this.isCheckeds = false;
                      _hzcd = "3";
                    }else{
                      this.isCheckeds = true;
                      _hzcd = "2";
                    }
                  });
                },
            ),
            CustomCheckBoxWidget(
                StringConstant.INFO_INACCURATE,
                isChecked: isCheckeds,
                callback: (isChecked){
                  setState(() {
                    this.isCheckeds = !isChecked;
                    print(this.isCheckeds);
                    if(this.isCheckeds){
                      this.isChecked = false;
                      _hzcd = "2";
                    }else{
                      this.isChecked = true;
                      _hzcd = "3";
                    }
                  });
                },
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
            autofocus: false,
            decoration: InputDecoration.collapsed(

            ),
            onChanged: (value){
                _remarkTextController.text = value;
            },
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
                "确认",
                (){
                    Navigator.of(context).pop();
                    if(widget.callback != null){
                        widget.callback(_hzcd,_remarkTextController.text);
                    }
                },
               marginTop: ScreenUtil().setHeight(40),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _remarkTextController.removeListener(() { });
    _remarkTextController.dispose();
  }
}

