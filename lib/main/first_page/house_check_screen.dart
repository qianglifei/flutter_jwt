import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class HouseCheckScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return HouseCheckScreenState();
  }

}

class HouseCheckScreenState extends BaseWidgetState<HouseCheckScreen> {
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
        child: BaseTitleAppBar(
          "房屋核查",
          isShowRightWidget: false,
          isShowLeftBackIcon: true,
        )
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Text("房屋核查");
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}