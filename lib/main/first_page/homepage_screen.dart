import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil().setHeight(387),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(52, 135, 215, 1),
                      Color.fromRGBO(47, 134, 218,1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),
              ),
            ),
            Positioned(
              top: ScreenUtil().setHeight(32),
              left: ScreenUtil().setWidth(32),
              child: Text("数据概览",style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(255, 255, 255, 0.7)))
            ),

            Positioned(
                top: ScreenUtil().setHeight(32),
                right: ScreenUtil().setWidth(32),
                child: Text("截止 2020-08-01",style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Color.fromRGBO(255, 255, 255, 0.7)))
            ),

            Positioned(
                top: ScreenUtil().setHeight(112),
                left: ScreenUtil().setWidth(32),
                child: _buildImageTextWidget("images/icon_sum_people_count.png", "总人口/人")
            ),

            Positioned(
                top: ScreenUtil().setHeight(112),
                right : ScreenUtil().setWidth(32),
                child: _buildImageTextWidget("images/icon_sum_house_count.png", "出租房屋/户")
            ),


          ],
        )
      ],
    );
  }

  Widget _buildImageTextWidget(String urlIcon,String title){
    return Container(
      width: ScreenUtil().setWidth(476),
      height: ScreenUtil().setHeight(227),
      child: Stack(
        children: <Widget>[
          Positioned(
              child: Image.asset(
                urlIcon,
                width: ScreenUtil().setWidth(476),
                height: ScreenUtil().setHeight(227),
                fit: BoxFit.cover,
              ),
          ),
          Positioned(
              top: ScreenUtil().setHeight(30),
              left: ScreenUtil().setWidth(32),
              child: Text(title,style: TextStyle(fontWeight: FontWeight.w700,fontSize: ScreenUtil().setSp(40),color: Color.fromRGBO(255, 255, 255, 0.7)))
          ),
          Positioned(
              top: ScreenUtil().setHeight(118),
              right: ScreenUtil().setWidth(20),
              child: Text("806188",style: TextStyle(fontWeight: FontWeight.w700,fontSize: ScreenUtil().setSp(80),color: Color.fromRGBO(255, 255, 255, 0.7)))
          ),
        ],
      )
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}