import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:jwt/entity/pcs_fwz_entity.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_screen.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_camera_page.dart';
import 'package:jwt/widget/custom_choose_bottom_sheet.dart';
import 'package:jwt/widget/custom_choose_widget.dart';
import 'package:jwt/widget/custom_input_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PeopleCheckScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return PeopleCheckScreenState();
  }
}

class PeopleCheckScreenState extends BaseWidgetState<PeopleCheckScreen> {
  List<PcsFwzEntity> _list = [];
  String _title = "";
  Color _color;
  bool _isVisible  = false;
  int position = 100000;
  SharedPreferences prefs;
  String _pcsbm = "";
  String _pcsbh = "";
  String _fwzbh = "";
  String imagePath;
  @override
  initState(){
    // TODO: implement initState
    super.initState();
    SqlManager.copyDbFileToCacheDocument();
    getData();
  }

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _pcsbm = prefs.getString("pcsbm");
      print(_pcsbm);
    });
  }

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
    return Container(
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().uiSize.height,
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
              callBack: (String key){
                setState(() {
                  _pcsbh = key;
                  print("派出所编号:$_pcsbh");
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
            child:CustomChooseBottomSheet(
                "服务站",
                tableName: "TYPT_FWZGFGL_FWZJBXXDJB",
                pcsbm: _pcsbh,
                callBack: (String key){

                }
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(64),top: ScreenUtil().setHeight(44)),
            child: Text("个人信息",style: TextStyle(fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),color: Color.fromRGBO(140,141,142,1))),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(44)),
            child: CustomInputWidget(
              "姓名",hint: "请输入姓名",
          )),
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
              "证件号码",hint: "请输入身份证号码",
              )
          ),
          Padding(
            padding: EdgeInsets.only(left:ScreenUtil().setWidth(140),top: ScreenUtil().setHeight(56)),
            child: _buildScanWidget(),
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
                    "离线暂存",
                   (){
                     print("离线暂存");
                   }
               ),
                CustomButton(
                    ScreenUtil().setWidth(450),
                    ScreenUtil().setHeight(120),
                    Colors.blue,
                    Colors.white,
                    "线上核查",
                    (){
                      print("线上核查");
                      Navigator.push(context,MaterialPageRoute(builder:(_){
                        return PeopleOnlineCheckScreen();
                      }));
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget _buildScanWidget(){
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(800),
        height: ScreenUtil().setHeight(240),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(52,135,215,1),width: 1),
          boxShadow: [BoxShadow(color: Color.fromRGBO(247,248,250,1), offset: Offset(5.0, 5.0),blurRadius: 10.0, spreadRadius: 2.0)],
          // 默认值也是矩形
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
                left: ScreenUtil().setWidth(73),
                top: ScreenUtil().setHeight(40),
                child: Image.asset("images/icon_ocr.png",
                  width: ScreenUtil().setWidth(320),
                  height: ScreenUtil().setHeight(160),
                  fit: BoxFit.fill,
                ),
            ),
            Positioned(
              left: ScreenUtil().setWidth(430),
              top: ScreenUtil().setHeight(75),
              child:Text("身份证识别",style: TextStyle(fontSize: ScreenUtil().setSp(64,allowFontScalingSelf: true),color: Color.fromRGBO(58,134,255,1)))
            ),
          ],
        ),
      ),
      onTap: (){
          print("身份证识别");
          requestPermission();
      },
    );
  }
  
  Widget _buildChooseWidget(String title) {
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
                child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
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
  ///动态权限申请
  Future requestPermission() async{
    //申请权限
    Map<PermissionGroup,PermissionStatus> permisson =
       await PermissionHandler().requestPermissions([PermissionGroup.camera,PermissionGroup.storage]);
    //申请结果
    PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if(permissionStatus == PermissionStatus.granted){
      Navigator.
      push(context, MaterialPageRoute(builder: (context) => CustomCameraPage())).
      then((value) {
          if(value != null){
            setState(() {
              imagePath = value;
            });
          }
      });
    }else{
      //权限申请被拒绝，自己去处理
    }
  }
}