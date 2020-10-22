import 'package:flutter/material.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class SplashScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return new SplashScreenState();
  }
}

class SplashScreenState extends BaseWidgetState<SplashScreen> {
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return null;
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Container(
      child: Image.asset(
        "images/icon_splash_gb.png",
        fit: BoxFit.fitHeight,
        //无限大
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}