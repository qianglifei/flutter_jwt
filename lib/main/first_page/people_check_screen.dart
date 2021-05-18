import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:jwt/entity/pcs_fwz_entity.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_bloc.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_response_entity.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_screen.dart';
import 'package:jwt/utils/idcard_utils.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_camera_page.dart';
import 'package:jwt/widget/custom_choose_bottom_sheet.dart';
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
  String name = "";
  String sfzhm = "";
  String returnBz = "";
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
    return SingleChildScrollView(
     //TODO 滚动特性，允许滚出边界，出边界后会弹会来
    physics: BouncingScrollPhysics(),
      child: _buildLayout(context),
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
    var status = await Permission.camera.isGranted;
    if(status){
      print("授权成功");
      Navigator.push(context, MaterialPageRoute(builder: (context) => CustomCameraPage()));
    }else{
      print("授权失败");
    }
  }

  Widget _buildLayout(BuildContext context){
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
                "姓名",
                hint: "请输入姓名",
                callBack: (value){
                  print(value);
                  name = value;
                },

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
                "证件号码",
                hint: "请输入身份证号码",
                callBack: (value){
                  print(value);
                  sfzhm = value;
                },
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
                      if(IdCardUtils().isIdCard(sfzhm)){
                        buildShowDialog(context);
                        Map<String,String> requestBody = new Map();
                        requestBody.addAll({
                          "rdj_sspcsbm":_pcsbm,
                          "bip_xm":name,
                          "bip_sfzhm":sfzhm,
                        });
                        DioUtils.instance.postHttps<PeopleOnlineCheckResponseReturnData>(
                            url:URLConfig.rkhc_rkhccx,
                            parameters: requestBody,
                            method: DioUtils.POST,
                            onSuccess: (data){
                              print(data);
                              print(data);
                              Navigator.of(context).pop();
                              if(data.returnCode == -10){
                                Navigator.of(context).pop();
                                Navigator.push(context,MaterialPageRoute(builder:(context){
                                  return BlocProvider(
                                    create: (context)=> PeopleOnlineCheckBloc(),
                                    child: PeopleOnlineCheckScreen(
                                      returnMsg: data.returnMsg,
                                      returnStandAdder: data.returnStandAdder,
                                      returnType: data.returnType,
                                      shzhm: sfzhm,
                                      xm: name,
                                      returnBz:data.returnBz,
                                    ),
                                  );
                                }));
                              }else if(data.returnCode == 1){
                                Navigator.push(context,MaterialPageRoute(builder:(context){
                                  return BlocProvider(
                                    create: (context)=> PeopleOnlineCheckBloc(),
                                    child: PeopleOnlineCheckScreen(mEntity: data.returnData,returnMsg: data.returnMsg,returnStandAdder: data.returnStandAdder,returnType: data.returnType),
                                  );
                                }));
                              }
                            },
                            onError: (errorInfo){
                              Navigator.of(context).pop();
                              print(errorInfo);
                            }
                        );
                      }
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return  Center(
              child: Container(
                  padding:const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    //黑色背景
                      color: Colors.black87,
                      //圆角边框
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    //控件里面内容主轴负轴剧中显示
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //主轴高度最小
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                                '加载中...',
                                style: TextStyle(fontSize:15,color: Colors.white,decoration: TextDecoration.none,)
                            )
                        )
                      ]
                  )));
        });
  }
}