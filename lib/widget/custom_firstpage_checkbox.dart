import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CustomCheckBox extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCheckBoxState();
  }

}

class CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        child: Container(
            width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setHeight(64),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Image.asset(
                  "images/icon_stretch_background.png",
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(64),
                  fit: BoxFit.fill,
                ),
                Positioned(
                    top: ScreenUtil().setWidth(18),
                    left: ScreenUtil().setHeight(110),
                    child:Image.asset(
                      _isChecked ? "images/icon_stretch_down.png" : "images/icon_stretch_up.png",
                      width: ScreenUtil().setWidth(42),
                      height: ScreenUtil().setHeight(24),
                      fit: BoxFit.fill,
                    )
                )
              ],
            ),
        ),
        onTap: (){
            setState(() {
                _isChecked = !_isChecked; 
            });
        },
    );
  }
}