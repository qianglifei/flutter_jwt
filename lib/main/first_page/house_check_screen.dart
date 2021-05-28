import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_choose_bottom_sheet.dart';
import 'package:jwt/widget/custom_choose_widget.dart';
import 'package:jwt/widget/custom_input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HouseCheckScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return HouseCheckScreenState();
  }

}

class HouseCheckScreenState extends BaseWidgetState<HouseCheckScreen> {

  bool _isVisiableFWZ = true;
  String _pcsbm = "";
  String _pcsbh = "";
  String _rdj_sspcsbm = "";
  String _fwzjbxxdjb_fwzbh = "";
  SharedPreferences prefs;
  String _account_authority = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _pcsbm = prefs.getString("pcsbm");
      _account_authority = prefs.getString("Account_authority");
      // 0 是分局
      if(_account_authority == "0"){
        _isVisiableFWZ = true;
        // 1 是派出所
      }else if(_account_authority == "1"){
        _isVisiableFWZ = false;
      }
      print(_pcsbm);
    });
  }

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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: ScreenUtil().uiSize.width,
        color: Color.fromRGBO(247,248,250,1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(64),top: ScreenUtil().setHeight(44)),
              child: Text("核查区域",style: TextStyle(fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),color: Color.fromRGBO(140,141,142,1))),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(44)),
              child:CustomChooseBottomSheet(
                  "派出所",
                  tableName: "PCSFWZDID_ONLY",
                  pcsbm: _pcsbm,
                  callBack: (key){
                    setState(() {
                      _rdj_sspcsbm = key;
                      print("派出所编号:$key");
                    });
                  }
              ),
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
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
                child: Offstage(
                  offstage: _isVisiableFWZ,
                  child: CustomChooseBottomSheet(
                      "服务站",
                      tableName: "TYPT_FWZGFGL_FWZJBXXDJB",
                      pcsbm: _pcsbh,
                      callBack: (key){
                        setState(() {
                          _fwzjbxxdjb_fwzbh = key;
                        });
                      }
                  ),
                )

            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(64),top: ScreenUtil().setHeight(44)),
              child: Text("房屋信息",style: TextStyle(fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),color: Color.fromRGBO(140,141,142,1))),
            ),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(44)),
                child: CustomInputWidget(
                  "房主姓名",hint: "请输入房主姓名",
                )
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
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
                child: CustomInputWidget(
                  "房屋登记表序号",hint: "请输入序号",
                )
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
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
                child:CustomInputWidget(
                  "详细地址",hint: "请输入详细地址",
                )
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(300)),
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
                      }
                  ),
                  CustomButton(
                      ScreenUtil().setWidth(450),
                      ScreenUtil().setHeight(120),
                      Colors.blue,
                      Colors.white,
                      "核查",
                          (){
                        print("核查");


                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
}