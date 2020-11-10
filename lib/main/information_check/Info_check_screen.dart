import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class InfoCheckScreen extends BaseWidget{

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return InfoCheckScreenState();
  }

}

class InfoCheckScreenState extends BaseWidgetState<InfoCheckScreen> {
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return null;
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Center(
      child: Text("信息核查"),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}