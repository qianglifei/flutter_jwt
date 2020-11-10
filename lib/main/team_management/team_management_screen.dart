import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class TeamManagementScreen extends BaseWidget{

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return TeamManagementScreenState();
  }

}

class TeamManagementScreenState extends BaseWidgetState<TeamManagementScreen> {
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return null;
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Center(
      child: Text("队伍管理"),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}