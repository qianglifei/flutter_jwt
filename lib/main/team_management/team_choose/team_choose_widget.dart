
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/config/color_constant.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:jwt/main/team_management/team_choose/team_choose_bloc.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_choose_bottom_sheet.dart';
import 'package:jwt/widget/custom_choose_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamChooseWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TeamChooseWidgetState();
  }
}

class TeamChooseWidgetState extends State<TeamChooseWidget> {
  String _pcsbm;
  String _mjzh;
  String _account_authority;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SqlManager.copyDbFileToCacheDocument();
    getData();
  }

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _pcsbm = prefs.getString("pcsbm");
      _account_authority = prefs.getString("Account_authority");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamChooseBloc,TeamChooseState>(
        builder: (context,state){
          return Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            color: ColorConstant.TEAM_BACKGROUND,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(64),top: ScreenUtil().setHeight(50),bottom: ScreenUtil().setHeight(30)),
                  child: Text(
                      "队伍管理",
                      style: TextStyle(fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
                          color: ColorConstant.TEXT_COLOR_GRAY
                      )
                  ),
                ),
                CustomChooseBottomSheet(
                    "派出所",
                    tableName: "PCSFWZDID_ONLY",
                    pcsbm: _pcsbm,
                    callBack: (key){
                      setState(() {
                        _pcsbm = key;
                        print("派出所编号:$key");
                      });
                    }
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
                CustomChooseBottomSheet(
                    "民警",
                    tableName: "PCSFWZDID_ONLY",
                    pcsbm: _pcsbm,
                    callBack: (key){
                      setState(() {
                        _pcsbm = key;
                        print("派出所编号:$key");
                      });
                    }
                ),
                Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(66)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          CustomButton(
                              ScreenUtil().setWidth(450),
                              ScreenUtil().setHeight(120),
                              Colors.white,
                              Colors.blue,
                              "重置",
                                  (){
                                print("重置");
                                _mjzh = "";
                                _pcsbm = "";
                              }
                          ),
                          CustomButton(
                              ScreenUtil().setWidth(450),
                              ScreenUtil().setHeight(120),
                              Colors.blue,
                              Colors.white,
                              "确定",
                                  (){
                                print("确定");
                              }
                          ),
                        ]
                    )
                ),
              ],
            ),
          );
        }
    );
  }
}