import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/config/color_constant.dart';
import 'package:jwt/widget/custom_checkbox.dart';

// ignore: must_be_immutable
class ShowAlertDialog extends StatefulWidget {
  // 内容区域布局
  TextAlign contentAlign;

  String title;

  String content;
  // 点击返回index 0 1
  Function onTap;
  //按钮
  List<String> items;

  ShowAlertDialog({
    this.contentAlign = TextAlign.left,
    this.onTap,
    @required this.items,
    this.content,
    this.title,
  });

  @override
  _ShowAlertDialogState createState() => _ShowAlertDialogState();
}

class _ShowAlertDialogState extends State<ShowAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        // ClipRRect 创建圆角矩形 要不然发现下边button不是圆角
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: ColorConstant.CUSTOM_ALERT_BACKGROUND,
            width: ScreenUtil().setWidth(952),
            height: ScreenUtil().setHeight(795),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(144),
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Color.fromRGBO(52, 135, 215, 1),
                      fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                _buildCheckBoxWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBoxWidget(){
    return CustomCheckBox();
  }

  Widget _itemCreat() {
    return Container(
      child: Row(
        children: widget.items.map((res) {
          int index = widget.items.indexOf(res);
          return Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                widget.onTap(index);
              },
              child: Container(
                height: 44,
                alignment: Alignment.center,
                child: Text(
                  res,
                  style: TextStyle(
                      color: ColorConstant.CUSTOM_ALERT_BLACK,
                      fontSize:  ScreenUtil().setSp(15,allowFontScalingSelf: true)
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}