import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_bloc.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_id_card_widget.dart';
import 'package:jwt/widget/custom_input_widget.dart';


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
    return BlocBuilder<PeopleOnlineCheckBloc,PeopleOnlineCheckState>(
        builder: (context,state){
          return SingleChildScrollView(
            //TODO 滚动特性，允许滚出边界，出边界后会弹会来
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIDCard(),
                _buildBaseInfoWidget("基本信息"),
                CustomInputWidget(
                    "现住地址"
                ),
                //横线
                Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40),right: ScreenUtil().setWidth(40)),
                    child: Container(
                        width: ScreenUtil().uiSize.width,
                        height: ScreenUtil().setHeight(3),
                        color: Color.fromRGBO(247,248,250,1)
                    )
                ),
                CustomInputWidget(
                    "手机号码"
                ),
                _buildBaseInfoWidget("信息备注"),
              ],
            ),
          );
        }
    );

  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget _buildBaseInfoWidget(String title) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(64)),
      color: Color.fromRGBO(247, 248, 250, 1),
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().setHeight(144),
      child: Text(title,style: TextStyle(color: Color.fromRGBO(140, 141, 142, 1),fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true))),
    );
  }
}