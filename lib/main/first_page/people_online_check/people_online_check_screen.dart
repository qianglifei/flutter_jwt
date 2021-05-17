import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/main/first_page/homepage_screen.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_bloc.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_response_entity.dart';
import 'package:jwt/utils/age_utils.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_choose_bottom_sheet.dart';
import 'package:jwt/widget/custom_choose_widget.dart';
import 'package:jwt/widget/custom_id_card_widget.dart';
import 'package:jwt/widget/custom_input_widget.dart';

// ignore: must_be_immutable
class PeopleOnlineCheckScreen extends BaseWidget{
  PeopleOnlineCheckResponseReturnData mEntity;
  String returnMsg;
  String returnStandAdder;
  String returnType;
  String shzhm;
  String xm;
  String returnBz;
  PeopleOnlineCheckScreen({this.mEntity,this.returnMsg,this.returnStandAdder,this.returnType,this.shzhm,this.xm,this.returnBz});

  @override
  BaseWidgetState<BaseWidget> getState()  {
    return new PeopleOnlineCheckScreenState();
  }
}

class PeopleOnlineCheckScreenState  extends BaseWidgetState<PeopleOnlineCheckScreen>{
  PeopleOnlineCheckBloc _bloc;
  String _name = "";
  String _idCard = "";
  String _birthDate = "";
  String _nation = "";
  String _headImagePath = "";
  String _isStandardAddress = "";
  String _residentAddress = "";
  String _isRegister = "";
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = PeopleOnlineCheckBloc();
    initData();
  }

  void initData(){
    setState(() {
        _isRegister = widget.returnMsg.contains("该人员未登记")  ? "-10" : "1";
        _isStandardAddress = widget.returnStandAdder ?? "";
        if(_isRegister == "-10"){
          if(widget.returnBz != null){
              Fluttertoast.showToast(msg: widget.returnBz);
          }
          _idCard = widget.shzhm ?? "";
          _name = widget.xm ?? "";
          _birthDate = AgeUtils().getBirthday(_idCard);
        }else if(_isRegister == "1"){
            _name = widget.mEntity.bipXm ?? "";
            _idCard = widget.mEntity.bipSfzhm ?? "";
            _birthDate = widget.mEntity.bipBirthday ?? "";
            _headImagePath = widget.mEntity.img ?? "";
            _nation = widget.mEntity.bipNation;
            _residentAddress = widget.mEntity.bipRprAddress;
            if(_birthDate.isNotEmpty){
              _birthDate = _birthDate.substring(0,4) + "-${_birthDate.substring(4,6)}" + "-${_birthDate.substring(6,8)}";
            }
        }
    });
  }

  @override
  Widget getContentWidget(BuildContext context) {
    return BlocBuilder<PeopleOnlineCheckBloc,PeopleOnlineCheckState>(
         builder: (context,state){
             return Column(
               children: [
                 Expanded(
                   flex: 2,
                   child: SingleChildScrollView(
                     //TODO 滚动特性，允许滚出边界，出边界后会弹会来
                     physics: BouncingScrollPhysics(),
                     child: Column(
                       mainAxisSize: MainAxisSize.max,
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         CustomIDCard(_name,_idCard,_birthDate,_nation,_residentAddress,_isRegister),
                         _buildBaseInfoWidget("基本信息"),
                         CustomInputWidget(
                           "现住地址",
                           hint: "请输入现住地址",
                           content: "",
                           callBack: (value){
                             print(value);
                           },
                         ),
                         _buildStandardWidget(_isStandardAddress),
                         //横线
                         _buildLineWidget(),
                         CustomInputWidget(
                           "手机号码",
                           hint: "请输入手机号码",
                           content: "",
                           callBack: (value){
                             print(value);
                           },
                         ),
                         _buildBaseInfoWidget("信息备注"),
                         CustomChooseWidget(
                             "核准程度",
                             callBack: (){

                             }
                         ),
                         //横线
                         _buildLineWidget(),
                         CustomInputWidget(
                             "备注信息"
                         ),
                       ],
                     ),
                   ),
                 ),
                 _buildCustomButtonWidget(),
               ],
             );
           }
       );
  }
  /// 加载进度条
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
  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }
  
  Widget _buildStandardWidget(String standardAddress) {
    print(standardAddress);
    return standardAddress == "0" ? Container(
      height: ScreenUtil().setHeight(80),
      child: Stack(
        children: [
          Positioned(
              right: ScreenUtil().setWidth(220),
              child: Image.asset(
                 "images/icon_ban.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
              )
          ),
          Positioned(
              right: ScreenUtil().setWidth(10),
              child: Text("非标准地址",style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ): Container(
        height: ScreenUtil().setHeight(80),
        child: Stack(
          children: [
            Positioned(
              right: ScreenUtil().setWidth(10),
              child: Text("标准地址",style: TextStyle(color: Colors.green)),
            ),
          ],
      ),
    );
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
  ///构建横线Widget
  Widget _buildLineWidget() {
    return Padding(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(40),right: ScreenUtil().setWidth(40)),
        child: Container(
            width: ScreenUtil().uiSize.width,
            height: ScreenUtil().setHeight(3),
            color: Color.fromRGBO(247,248,250,1)
        )
    );
  }

  ///构建提交按钮
  Widget _buildCustomButtonWidget() {
     return CustomButton(
       ScreenUtil().setWidth(952),
       ScreenUtil().setHeight(120),
       Colors.blue,
       Colors.white,
       "提交",
       (){
         print("线上核查");
//         Navigator.push(context,MaterialPageRoute(builder:(_){
//           return BlocProvider(
//             create: (context)=> PeopleOnlineCheckBloc(),
//             child:
//           );
//         }));
       },
       marginBottom: ScreenUtil().setHeight(56),
     );
  }

  buildShowDialogs(BuildContext context) {
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