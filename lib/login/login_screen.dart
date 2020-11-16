

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class LoginScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return LoginScreenState();
  }
}

class LoginScreenState extends BaseWidgetState<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //设置AppBar不可见
    setAppBarVisible(false);
  }

  @override
  CustomAppBar getAppBar() {
    return CustomAppBar(
      child: Container(
        color: Colors.blue,
        child: BaseTitleAppBar(),
      )
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Text("");
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }


}