import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BaseTitleAppBar extends StatefulWidget implements PreferredSizeWidget{
  @override
  State<StatefulWidget> createState() => BaseTitleAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(200);
}

class BaseTitleAppBarState extends State<BaseTitleAppBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    EdgeInsets edgeInsets = MediaQuery.of(context).padding;
    double padding = edgeInsets.top;
    return SafeArea(
        child: Container(
              width: MediaQuery.of(context).size.width,
              height:padding + widget.preferredSize.height,
              color: Colors.blue,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("左边返回按钮"),
                  Text("中间的标题"),
                  Text("右边的按钮"),
                ],
        ),
    )
    );
  }
}