import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';


// ignore: must_be_immutable
class MineScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return MineScreenState();
  }
}

class MineScreenState extends BaseWidgetState<MineScreen> {
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
      child: Container(
        child: BaseTitleAppBar(
            "个人中心",
            isShowLeftBackIcon: false,
            isShowRightWidget: false
        ),
      ),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    return Container(
      color: Color.fromRGBO(247,248,250,1),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil().uiSize.width,
            height: ScreenUtil().setHeight(650),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/icon_mine_bg.png",
                  height: ScreenUtil().setHeight(650),
                  width: ScreenUtil().uiSize.width,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    top: ScreenUtil().setHeight(193),
                    left: ScreenUtil().setWidth(460),
                    child: Image.asset(
                      "images/icon_police.png",
                      height: ScreenUtil().setHeight(160),
                      width: ScreenUtil().setWidth(160),
                      fit: BoxFit.fill,
                    )
                ),
                Positioned(
                    top: ScreenUtil().setHeight(400),
                    left: ScreenUtil().setWidth(400),
                    child: Text("霍营派出所",style: TextStyle(fontSize: ScreenUtil().setSp(56),color: Color.fromRGBO(255, 255, 255, 1)))
                )

              ],
            ),
          ),
          buildModifyPasswordWidget(),
          //横线
          Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(40),right: ScreenUtil().setWidth(40)),
              child: Container(
                  width: ScreenUtil().uiSize.width,
                  height: ScreenUtil().setHeight(3),
                  color: Color.fromRGBO(247,248,250,1)
              )
          ),
          buildExitLoginWidget(),
          Container(

            constraints:BoxConstraints(

              maxHeight:200.0,

              minHeight:50.0,

            ),

            decoration:BoxDecoration(

                color: Colors.grey[200],

                borderRadius:BorderRadius.all(Radius.circular(10))

            ),

            padding:EdgeInsets.only(

                left:16.0, right:16.0, top:8.0, bottom:4.0),

            child:TextField(

              maxLines:null,

              keyboardType: TextInputType.multiline,

              autofocus:true,

              decoration:InputDecoration.collapsed(

                hintText:"备注",

              ),

            ),

          )
        ],
      )
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget buildModifyPasswordWidget() {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(144),
        width: ScreenUtil().uiSize.width,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: ScreenUtil().setHeight(47),
                left: ScreenUtil().setWidth(64),
                child: Text("修改密码",style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
            ),
            Positioned(
                top: ScreenUtil().setHeight(50),
                right: ScreenUtil().setWidth(64),
                child: Image.asset(
                  "images/icon_more.png",
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(36),
                  fit: BoxFit.cover,
                )
            ),
          ],
        ),
      ),
      onTap: (){

      },
    );

  }
  Widget buildExitLoginWidget() {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(144),
        width: ScreenUtil().uiSize.width,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: ScreenUtil().setHeight(47),
                left: ScreenUtil().setWidth(64),
                child: Text("退出登录",style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
            ),
            Positioned(
                top: ScreenUtil().setHeight(50),
                right: ScreenUtil().setWidth(64),
                child: Image.asset(
                  "images/icon_more.png",
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(36),
                  fit: BoxFit.cover,
                )
            ),
          ],
        ),
      ),
      onTap: (){
        _onBackPressed();
      },
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('确定退出程序吗?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('暂不'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text('确定'),
                  onPressed: () => exit(0),
                ),
              ],
            ));
  }

}