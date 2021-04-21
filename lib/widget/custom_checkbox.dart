import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/config/color_constant.dart';
import 'package:jwt/config/string_constant.dart';

class CustomCheckBox extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCheckBoxWidgetState();
  }
}

class CustomCheckBoxWidgetState extends State<CustomCheckBox>{
  bool _isChecked = false;
  bool _isCheckeds = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildChecked(_isChecked),
        _buildCheckeds(_isCheckeds)
      ],
    );
  }


  Widget _buildChecked(bool isChecked){
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
                  color: _isChecked ? ColorConstant.CUSTOM_INFO_CHECKED : ColorConstant.CUSTOM_INFO_UNCHECKED,
                  fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true)
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(width: 0.7,color: _isChecked ? ColorConstant.CUSTOM_INFO_CHECKED : ColorConstant.CUSTOM_INFO_UNCHECKED)
            ),
          ),
          Positioned(
            right: ScreenUtil().setWidth(0),
            bottom:  ScreenUtil().setHeight(0),
            child: Offstage(
                offstage: _isChecked,
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
          _isChecked = !_isChecked;
        });
      },
    );
  }

  Widget _buildCheckeds(bool isChecked){
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
                  color: _isChecked ? ColorConstant.CUSTOM_INFO_CHECKED : ColorConstant.CUSTOM_INFO_UNCHECKED,
                  fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true)
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(width: 0.7,color: _isChecked ? ColorConstant.CUSTOM_INFO_CHECKED : ColorConstant.CUSTOM_INFO_UNCHECKED)
            ),
          ),
          Positioned(
            right: ScreenUtil().setWidth(0),
            bottom:  ScreenUtil().setHeight(0),
            child: Offstage(
                offstage: _isChecked,
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
          _isChecked = !_isChecked;
        });
      },
    );
  }
}

