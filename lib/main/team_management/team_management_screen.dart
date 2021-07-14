import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/main/team_management/team_choose/team_choose_bloc.dart';
import 'package:jwt/main/team_management/team_choose/team_choose_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_firstpage_checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_bean.dart';

// ignore: must_be_immutable
class TeamManagementScreen extends BaseWidget{

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return TeamManagementScreenState();
  }
}

class TeamManagementScreenState extends BaseWidgetState<TeamManagementScreen> {
  String _title = "队伍管理";
  bool _rightIcon = false;
  bool _isShowTeamManagement = false;
  String _authority = "";
  SharedPreferences prefs;
  String _policeCode = "";
  String _policemanCode = "";
  bool _isShowImageTextsWidget = false;
  bool _isShowTextWidget = true;
  String _hjrk = "0",_ldrk = "0",_jwrk = "0";
  List<DataBean> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _policeCode = prefs.getString("pcsbm");
      _authority = prefs.getString("Account_authority");
      if(_authority == "0"){
        //0 是分局
        _isShowTeamManagement = true;
      }else if(_authority == "2"){
        //1 是派出所领导
        _isShowTeamManagement = true;
      }else{
        //2 派出所民警
        _isShowTeamManagement = false;
      }
      _isShowTeamManagement = true;
      print(_policeCode);
      initData();
    });
  }

  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
        child: BaseTitleAppBar(
          _title,
          isShowLeftBackIcon: false,
          isShowRightWidget: _rightIcon,
          rightClick: (){

          },
        ),
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // 根据权限，显示不同的数据
    return _isShowTeamManagement ? BlocProvider(
        create: (context)=> TeamChooseBloc(),
        child:  TeamChooseWidget(),
    ): _buildStatisticsWidget();

  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget _buildStatisticsWidget(){
    // TODO: implement getContentWidget
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setHeight(387),
                  color:Color.fromRGBO(47, 134, 218,1)
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
          ),
          _buildMultilineTextWidget(),
          CustomCheckBox(callBack: (_checkedStatus){
            if(_checkedStatus){
              setState(() {
                _isShowImageTextsWidget = true;
                _isShowTextWidget = false;
                print(_isShowImageTextsWidget);
              });
            }else{
              setState(() {
                _isShowImageTextsWidget = false;
                _isShowTextWidget = true;
                print(_isShowImageTextsWidget);
              });
            }
          }),
          _buildHorizontalImage(),
          Container(
             height: ScreenUtil().setHeight(24),
             width: ScreenUtil().screenWidth,
             color: Color.fromRGBO(247,248,250,1),
             child: Text(""),
          ),
          //管辖区域
          _buildNoticeWidget(),
          Container(
            height: ScreenUtil().setHeight(24),
            width: ScreenUtil().screenWidth,
            color: Color.fromRGBO(247,248,250,1),
            child: Text(""),
          ),
          //本月数据概览
          _buildDataOverviewWidget(),
        ],
      ),
    );
  }

  ///本月数据量统计
  Widget _buildDataOverviewWidget(){
    return Container(
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().setHeight(791),
      color: Color.fromRGBO(247,248,250,1),
      child: Column(
        children: <Widget>[
          Container(
              width: ScreenUtil().uiSize.width,
              height: ScreenUtil().setHeight(90),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
                    child:  Text("本月数据概览",style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(34,34,34,1))),
                  ),
                  Positioned(
                    right: ScreenUtil().setWidth(38),
                    child: Text("截止 2020-08-01",style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Color.fromRGBO(140,141,142,1))),
                  ),
                ],
              )
          ),
          Expanded(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 3,
                        //主方向的Item间隔 竖直方向
                        mainAxisSpacing: 12,
                        //次方向的Item间隔
                        crossAxisSpacing: 12,
                        //子Item 的宽高比
                        childAspectRatio: 1.5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //Widget Function(BuildContext context, int index)
                      return getItemContainer(dataList[index]);
                    })
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalImage(){
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().setHeight(212),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
             padding: EdgeInsets.only(left: ScreenUtil().setWidth(64)),
             child: Image.asset(
               "images/icon_zzgly.png",
               width: ScreenUtil().setWidth(128),
               height: ScreenUtil().setHeight(115),
               fit: BoxFit.fill,
             ),
          ),
           Container(
              height: ScreenUtil().setHeight(122),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "专职管理员",
                    style: TextStyle(fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true),color: Color.fromRGBO(34,34,34,1)),
                  ),
                  Expanded(
                      child: Text(""),
                  ),
                  Text(
                    "5人",
                    style: TextStyle(fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true),color: Color.fromRGBO(34,34,34,1)),
                  ),
                ],
              ),
           ),
          Padding(
               padding: EdgeInsets.only(left: ScreenUtil().setWidth(164)),
                child: Image.asset(
                  "images/icon_gzl.png",
                  width: ScreenUtil().setWidth(128),
                  height: ScreenUtil().setHeight(115),
                  fit: BoxFit.fill,
            ),
          ),
           Padding(
               padding: EdgeInsets.only(left: ScreenUtil().setWidth(23)),
               child: Text(
                 "工作量统计",
                 style: TextStyle(fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true),color: Color.fromRGBO(34,34,34,1)),
               ),
           ),
        ],
      ),
    );
  }

  Widget _buildMultilineTextWidget(){
    return Offstage(
        offstage: _isShowTextWidget,
        child:Container(
            width: ScreenUtil().uiSize.width,
            height: ScreenUtil().setHeight(220),
            color: Color.fromRGBO(57, 147, 242, 1),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _multilineTextWidget("户籍人口",_hjrk),
                    _multilineTextWidget("流动人口",_ldrk),
                    _multilineTextWidget("境外人口",_jwrk),
                  ],
                ),
              ],
            )
        )
    );
  }
  ///通知公告控件
  Widget _buildNoticeWidget() {
    return Container(
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().setHeight(120),
      color: Color.fromRGBO(255, 255, 255,1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(51)),
              child: Image.asset(
                "images/icon_fxqy.png",
                width: ScreenUtil().setWidth(89),
                height: ScreenUtil().setHeight(110),
                fit: BoxFit.fill,
              ),
          ),
          Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(36),right: ScreenUtil().setWidth(38)),
              child: Text("8月26日，中国人民警察警旗授旗仪式...",
                style: TextStyle(fontSize: ScreenUtil().setSp(40),
                    color: Color.fromRGBO(140,141,142,1)),
                overflow:TextOverflow.ellipsis,
              )
          ),
        ],
      ),
    );
  }
  Widget _multilineTextWidget(String textTitle,String content){
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
      height: ScreenUtil().setHeight(167),
      child: Column(
        children: <Widget>[
          Text(content,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(255, 255, 255, 1))),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(42)),
              child: Text(textTitle,style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Color.fromRGBO(255, 255, 255, 0.7)))
          ),
        ],
      ),
    );
  }

  Widget _singleLineTextWidget(){
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
      child: Row(
        children: <Widget>[
          Text("全职实管员",style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Color.fromRGBO(255, 255, 255, 0.7))),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
            child:  Text("646854",style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(255, 255, 255, 1))),
          ),
        ],
      ),
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

  Widget getItemContainer(DataBean dataBean) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(dataBean.content,style: TextStyle(fontSize: ScreenUtil().setSp(56),color:dataBean.contentColor)),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(24)),
              child: Text(dataBean.title,style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Color.fromRGBO(100,100,100,1)))
          ),
        ],
      ),
    );
  }

  void initData() {
      dataList.add(new DataBean("工作量合计"," 0",Color.fromRGBO(58,134,255,1)));
      dataList.add(new DataBean("人员录入"," 0",Color.fromRGBO(144,190,109,1)));
      dataList.add(new DataBean("人员迁移"," 0",Color.fromRGBO(249,132,74,1)));
      dataList.add(new DataBean("人员注销"," 0",Color.fromRGBO(58,134,255,1)));
      dataList.add(new DataBean("人员变更"," 0",Color.fromRGBO(144,190,109,1)));
      dataList.add(new DataBean("房屋录入"," 0",Color.fromRGBO(249,132,74,1)));
      dataList.add(new DataBean("房屋注销"," 0",Color.fromRGBO(58,134,255,1)));
      dataList.add(new DataBean("房屋变更"," 0",Color.fromRGBO(144,190,109,1)));
  }
}