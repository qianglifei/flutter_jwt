import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class BaseTitleAppBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => BaseTitleAppBarState();
}

class BaseTitleAppBarState extends State<BaseTitleAppBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("左边返回按钮"),
          Text("中间的标题"),
          Text("右边的按钮"),
        ],
    );
  }
}