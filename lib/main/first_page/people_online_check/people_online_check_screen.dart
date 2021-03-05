import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_bloc.dart';
import 'package:jwt/widget/custom_app_bar.dart';


// ignore: must_be_immutable
class PeopleOnlineCheckScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState()  => new PeopleOnlineCheckScreenState();
}

class PeopleOnlineCheckScreenState extends BaseWidgetState<PeopleOnlineCheckScreen>{
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
        child: BaseTitleAppBar(
          "人口核查",
          isShowRightWidget: false,
          isShowLeftBackIcon: true,
        )
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return BlocProvider(
        create: (BuildContext context){
          return PeopleOnlineCheckBloc();
        },
        child: SingleChildScrollView(
            //TODO 滚动特性，允许滚出边界，出边界后会弹会来
           physics: BouncingScrollPhysics(),
           child: Column(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [

             ],
           ),
        )
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}