import 'dart:html';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class BaseWidget extends StatefulWidget{
  BaseStateWidget baseStateWidget;
    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    baseStateWidget = getState();
    return baseStateWidget;
  }

  BaseStateWidget getState();
}

abstract class BaseStateWidget <T extends BaseWidget> extends State<T>{
  //导航栏是否显示
  bool _toolBarIsShow = true;
  //错误信息是否显示
  bool _errorWidgetIsShow = false;
  //错误信息内容
  String _errorMessage = "网络请求失败，请检查网络";
  //空信息
  String _emptyMessage = "暂无数据";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}
