import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/main/team_management/team_choose_widget.dart';
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
  String _title = "队伍管理";
  bool _rightIcon = false;
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
        child: BaseTitleAppBar(
          _title,
          isShowLeftBackIcon: false,
          isShowRightWidget: _rightIcon,
          rightClick: (){
            Fluttertoast.showToast(msg: "图片按钮被点击");
          },
        ),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return TeamChooseWidget();
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}