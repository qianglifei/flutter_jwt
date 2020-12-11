import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class HomepageScreen extends BaseWidget{

  @override
  BaseWidgetState<BaseWidget> getState() => HomepageScreenState();

}

class HomepageScreenState extends BaseWidgetState<HomepageScreen> {

  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
        child: Container(
            child: BaseTitleAppBar(
                "首页",
                isShowLeftBackIcon: false,
                isShowRightWidget: false
            ),
        ),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Center(
      child: Text("首页"),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}