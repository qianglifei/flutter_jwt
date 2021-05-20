import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/config/string_constant.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:jwt/main/first_page/homepage_screen.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_bloc.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_response_entity.dart';
import 'package:jwt/utils/age_utils.dart';
import 'package:jwt/utils/idcard_utils.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_choose_bottom_sheet.dart';
import 'package:jwt/widget/custom_choose_widget.dart';
import 'package:jwt/widget/custom_input_widget.dart';
import 'package:jwt/widget/custom_text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'nation_entity.dart';

// ignore: must_be_immutable
class PeopleOnlineCheckScreen extends BaseWidget{
  PeopleOnlineCheckResponseReturnData mEntity;
  String returnMsg;
  String returnStandAdder;
  String returnType;
  String shzhm;
  String xm;
  String returnBz;
  // ignore: non_constant_identifier_names
  String rdj_sspcsbm = "";
  // ignore: non_constant_identifier_names
  String fwzjbxxdjb_fwzbh = "";
  String grbh = "";
  PeopleOnlineCheckScreen({this.mEntity,this.returnMsg,this.returnStandAdder,
    this.returnType,this.shzhm,this.xm,this.returnBz,
    // ignore: non_constant_identifier_names
    this.rdj_sspcsbm,this.fwzjbxxdjb_fwzbh,this.grbh
  });

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
  String _nationCode = "";
  String _headImagePath = "";
  String _isStandardAddress = "";
  String _residentAddress = "";
  String _isRegister = "";
  String _hzcd = "核准程度";
  String _hzcdCode = "";
  String _bz = "";
  String _phoneNumber = "";
  String _registerTime = "";
  String _nowAddress = "";
  //姓名控制器
  TextEditingController nameController = TextEditingController();
  //户籍地址控制器
  TextEditingController residenceAddressController = TextEditingController();
  //民族列表
  List<NationEntity> _list;
  String _title = "";
  String _selectedContent = "请选择";
  String _content = "请选择民族";
  int position = 100000;
  SharedPreferences prefs;
  String _glybm = "";
  String _rdj_djrq = "";
  String _account_authority = "";
  bool _isVisiableFWZ = false;
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
    initLoginData();
    initData();
    // TODO: implement initState
    super.initState();
  }
  Future<void> initLoginData() async {
    prefs =  await SharedPreferences.getInstance();
  }
  void initData(){
    //将时间字符串转为时间对象
    String nowTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    setState(() {
        _isRegister = widget.returnMsg.contains("该人员未登记")  ? "-10" : "1";
        _isStandardAddress = widget.returnStandAdder ?? "";
        // 0 是分局
        if(_account_authority == "0"){
          _isVisiableFWZ = true;
          // 1 是派出所
        }else if(_account_authority == "1"){
          _isVisiableFWZ = false;
        }
        if(_isRegister == "-10"){
          if(widget.returnBz != null){
              Fluttertoast.showToast(msg: widget.returnBz);
          }
          _idCard = widget.shzhm ?? "";
          _name = widget.xm ?? "";
          nameController.text = _name;
          residenceAddressController.text =_residentAddress;
          _birthDate = AgeUtils().getBirthday(_idCard);
          _rdj_djrq = nowTime;
        }else if(_isRegister == "1"){
             _name = widget.mEntity.bipXm ?? "";
            _idCard = widget.mEntity.bipSfzhm ?? "";
            _birthDate = widget.mEntity.bipBirthday ?? "";
            _headImagePath = widget.mEntity.img ?? "";
            _nation = widget.mEntity.bipNation ?? "";
            _residentAddress = widget.mEntity.bipRprAddress ?? "";
            _nowAddress = widget.mEntity.rzfXzdxxdz ?? "";
            _phoneNumber = widget.mEntity.bipConTelephone ?? "";
            _glybm = widget.mEntity.rldGlybm ?? "";
            _rdj_djrq = widget.mEntity.rdjDjrq?? "";
            if(_birthDate.isNotEmpty){
              _birthDate = _birthDate.substring(0,4) + "-${_birthDate.substring(4,6)}" + "-${_birthDate.substring(6,8)}";
            }
            if(_rdj_djrq.isNotEmpty){
               _rdj_djrq = _rdj_djrq.substring(0,4) + "-${_rdj_djrq.substring(4,6)}" +
                   "-${_rdj_djrq.substring(6,8)}" + " ${_rdj_djrq.substring(8,10)}" +
                   ":${_rdj_djrq.substring(10,12)}" + ":${_rdj_djrq.substring(12,14)}";
            }
            if(_nation.isNotEmpty){
              _nationCode = _nation.split("-")[0];
              _nation = _nation.split("-")[1];
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
                         _buildIDCardWidget(context),
                         _buildBaseInfoWidget("基本信息"),
                         Padding(
                             padding: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
                             child: Offstage(
                               offstage: _isVisiableFWZ,
                               child: CustomChooseBottomSheet(
                                   "服务站",
                                   tableName: "TYPT_FWZGFGL_FWZJBXXDJB",
                                   pcsbm: widget.rdj_sspcsbm,
                                   callBack: (key){
                                     setState(() {

                                     });
                                   }
                               ),
                             )
                         ),
                         //横线
                         _buildLineWidget(),
                         CustomInputWidget(
                           "现住地址",
                           hint: "请输入现住地址",
                           content: _nowAddress,
                           callBack: (value){
                             _nowAddress = value;
                           },
                         ),
                         _buildStandardWidget(_isStandardAddress),
                         //横线
                         _buildLineWidget(),
                         CustomInputWidget(
                           "手机号码",
                           hint: "请输入手机号码",
                           content: _phoneNumber,
                           callBack: (value){
                              _phoneNumber = value;
                           },
                         ),
                         //横线
                         _buildLineWidget(),
                         CustomTextWidget(
                           "登记时间",
                           content: _rdj_djrq,
                           callBack: (value){
                             _phoneNumber = value;
                           },
                         ),
                         _buildBaseInfoWidget("信息备注"),
                         CustomChooseWidget(
                             _hzcd,
                             callBack: (value,remark){
                                 setState(() {
                                     _bz = remark;
                                     _hzcdCode = value;
                                     if(value == "2"){
                                         _hzcd = StringConstant.INFO_PRECISE;
                                     }else if(value == "3"){
                                         _hzcd = StringConstant.INFO_INACCURATE;
                                     }
                                 });
                             }
                         ),
                         //横线
                         _buildLineWidget(),
                         CustomInputWidget(
                             "备注信息",
                              enables: true,
                              content: _bz,
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
          Map<String,dynamic> requestMap = new Map();
          requestMap.addAll({
              "rdj_grbh": widget.grbh,
              "rdj_sspcsbm": widget.rdj_sspcsbm,
              "fwzjbxxdjb_fwzbh": widget.fwzjbxxdjb_fwzbh,
              "rld_glybm":_glybm,
              "bip_xm":_name,
              "bip_sfzhm":_idCard,
              "bip_xb":IdCardUtils().getGender(_idCard),
              "bip_birthday":_birthDate,
              "bip_nation":_nationCode,
              "bip_rpr_address":_residentAddress,
              "rzf_xzdxxdz":_nowAddress,
              "bip_con_telephone":_phoneNumber,
              "user_name":prefs.getString("user_name"),
              "user_gsdw":prefs.getString("user_gsdw"),
              "user_dwbm":prefs.getString("user_dwbm"),
              "rkhc_hcsj":"",
              "rkhc_hzcd":_hzcdCode,
              "_bz":_bz,
              "img":"",
              "rdj_djrq": "",
              "yj_lb": "1",
          });
          //登录请求
          BlocProvider.of<PeopleOnlineCheckBloc>(context).add(PeopleCheckEvent(map: requestMap));
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
  /// 构建IDCard Widget
  Widget _buildIDCardWidget(BuildContext context){
     return Container(
       width: ScreenUtil().uiSize.width,
       height: ScreenUtil().setHeight(611),
       decoration: BoxDecoration(
         //背景图片修饰
           image: DecorationImage(
               image: AssetImage("images/icon_card_bj.png"),
               //覆盖
               fit: BoxFit.cover
           )
       ),
       child: Stack(
         children: [
           Positioned(
             child: _buildInputTextWidget("姓        名",nameController,"姓名",_name),
           ),
           Positioned(
             child: _buildTextWidget("证件号码",_idCard),
             top: ScreenUtil().setHeight(100),
           ),
           Positioned(
             child: _buildTextWidget("出生日期",_birthDate),
             top: ScreenUtil().setHeight(200),
           ),
           Positioned(
             child: _buildChooseTextWidget("民        族",_nation),
             top: ScreenUtil().setHeight(300),
           ),
           Positioned(
             child: _buildInputTextWidget("户籍地址",residenceAddressController,"户籍地址",_residentAddress),
             top: ScreenUtil().setHeight(400),
           ),
           Positioned(
               top: ScreenUtil().setHeight(25),
               right: ScreenUtil().setWidth(47),
               child: GestureDetector(
                 child: Image.asset(
                   "images/icon_cart_title.png",
                   width: ScreenUtil().setWidth(260),
                   height: ScreenUtil().setHeight(320),
                   fit: BoxFit.contain,
                 ),
                 onTap: (){

                 },
               )
           ),
           Positioned(
             top: ScreenUtil().setHeight(290),
             right: ScreenUtil().setWidth(47),
             child: Image.asset(
               _isRegister == "-10"  ?  "images/icon_unregister.png" : "images/icon_register.png",
               width: ScreenUtil().setWidth(260),
               height: ScreenUtil().setHeight(320),
               fit: BoxFit.contain,
             ),
           ),
         ],
       ),
     );
  }

  //横排多个文本显示输入widget
  Widget _buildInputTextWidget(String title,TextEditingController controller,String hintText,String content) {
    controller.text = content;
    return Container(
      width: ScreenUtil().uiSize.width,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10),bottom: ScreenUtil().setHeight(10)),
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(64),
              top: ScreenUtil().setHeight(10),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Color.fromRGBO(42, 168, 245, 1),
                    fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true)
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(64),
                top: ScreenUtil().setHeight(15)
            ),
            child: Container(
              constraints:  BoxConstraints(
                maxHeight: 50.0,
                minHeight: 10.0,
              ),
              width: ScreenUtil().setWidth(460),
              child: TextField(
                autofocus: false,
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true)),
                decoration: InputDecoration(
                  fillColor: Colors.cyan,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  hintText:"请输入"+ hintText,
                ),
                onChanged: (value){
                  setState(() {
                    print(value);
                    _name = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //横排多个文本显示widget
  Widget _buildTextWidget(String title ,String content) {
    return Container(
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().setHeight(100),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10),bottom: ScreenUtil().setHeight(10)),
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(64),
              top: ScreenUtil().setHeight(10),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Color.fromRGBO(42, 168, 245, 1),
                    fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true)
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(64),
              top: ScreenUtil().setHeight(10),
            ),
            child: Text(content,
                style: TextStyle(
                    color:  Color.fromRGBO(34, 34, 34, 1),
                    fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true)
                )
            ),
          ),
        ],
      ),
    );
  }

  //横排文本选择widget
  Widget _buildChooseTextWidget(String title,String content) {
    _content = content ?? "";
    return Container(
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().setHeight(100),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(64),
              top: ScreenUtil().setHeight(10),
            ),
            child: Text(title, style: TextStyle(color: Color.fromRGBO(42, 168, 245, 1), fontSize: ScreenUtil().setSp(40, allowFontScalingSelf: true))),
          ),
          Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(64),
                top: ScreenUtil().setHeight(10),
              ),
              child: GestureDetector(
                child: Text(_content, style: TextStyle(color: Color.fromRGBO(34, 34, 34, 1), fontSize: ScreenUtil().setSp(40, allowFontScalingSelf: true))),
                onTap: () {
                  print("选择民族");
                  SqlManager.queryNationData().then((list) {
                    _list = list;
                    if (_list != null) {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, state) {
                              ///这里的state就是setState
                              return Container(
                                  height: ScreenUtil().setHeight(1200),
                                  width: ScreenUtil().uiSize.width,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: ScreenUtil().setHeight(130),
                                        width: ScreenUtil().uiSize.width,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            InkWell(
                                              child: Image.asset(
                                                "images/icon_close.png",
                                                width: ScreenUtil().setWidth(91),
                                                height: ScreenUtil().setHeight(91),
                                                fit: BoxFit.contain,
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Text("请选择民族", style: TextStyle(fontSize: ScreenUtil().setSp(56), color: Color.fromRGBO(52, 135, 215, 1))),
                                            InkWell(
                                              child: Text("确认", style: TextStyle(fontSize: ScreenUtil().setSp(56), color: Color.fromRGBO(52, 135, 215, 1))),
                                              onTap: () {
                                                setState(() {
                                                  _content = _selectedContent;
                                                  print("niha$_content");
                                                });
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: ScreenUtil().setHeight(24),
                                        color: Color.fromRGBO(247, 248, 250, 1),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: _list.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return GestureDetector(
                                              child: new Container(
                                                  color: position == index ? Color.fromRGBO(247, 248, 250, 1) : Colors.white,
                                                  width: ScreenUtil().uiSize.width,
                                                  height: ScreenUtil().setHeight(144),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                          top: ScreenUtil().setHeight(40),
                                                          left: ScreenUtil().setWidth(64),
                                                          child: Text(_list[index].value,
                                                              style: TextStyle(fontSize: ScreenUtil().setSp(44)))
                                                      ),
                                                      Positioned(
                                                          right: ScreenUtil().setWidth(64),
                                                          top: ScreenUtil().setHeight(45),
                                                          child: Offstage(
                                                            offstage: position == index ? false : true,
                                                            child: Image.asset(
                                                              "images/icon_select_true.png",
                                                              width: ScreenUtil().setWidth(48),
                                                              height: ScreenUtil().setHeight(32),
                                                              fit: BoxFit.contain,
                                                            ),
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              onTap: () {
                                                ///为了区分把setState改个名字
                                                state(() {
                                                  position = index;
                                                  _title = _list[position].value;
                                                  _selectedContent = _list[position].value;
                                                });
                                              },
                                            );
                                          },
                                          shrinkWrap: true,
                                        ),
                                      ),
                                    ],
                                  )
                              );
                            },
                          );
                        },
                      );
                    }
                  });
                },
              )
          ),
        ],
      ),
    );
  }


}