
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';

class AdministratorsScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return AdministratorsScreenState();
  }

}

class AdministratorsScreenState extends BaseWidgetState<AdministratorsScreen>{
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
        child: BaseTitleAppBar(
          "实管员列表",
          isShowLeftBackIcon: true,
          isShowRightWidget: false,
        )
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
     return Container(
       child: Text("实管员列表"),
     );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}