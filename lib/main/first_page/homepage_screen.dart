import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_firstpage_checkbox.dart';

// ignore: must_be_immutable
class HomepageScreen extends BaseWidget{

  @override
  BaseWidgetState<BaseWidget> getState() => HomepageScreenState();

}

class HomepageScreenState extends BaseWidgetState<HomepageScreen> {
  bool _isShowImageTextsWidget = false;
  bool _isShowTextWidget = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        _buildImageTextWidgets(),
        _buildLineWidget(),
        //监督核查widget
        _buildMonitorWidget(),
        _buildLineWidget(),
        //公告提醒
        _buildNoticeWidget(),
        _buildLineWidget(),
      ],
    );
  }
  Widget _buildMultilineTextWidget(){
    return Offstage(
      offstage: _isShowTextWidget,
      child:Container(
          width: ScreenUtil().uiSize.width,
          height: ScreenUtil().setHeight(332),
          color: Color.fromRGBO(57, 147, 242, 1),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _multilineTextWidget(),
                  _multilineTextWidget(),
                  _multilineTextWidget(),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _singleLineTextWidget(),
                  _singleLineTextWidget(),
                ],
              ),
            ],
          )
      )
    );
  }

  Widget _multilineTextWidget(){
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
      height: ScreenUtil().setHeight(167),
      child: Column(
        children: <Widget>[
          Text("646854",style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(255, 255, 255, 1))),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(42)),
              child: Text("户籍人口",style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Color.fromRGBO(255, 255, 255, 0.7)))
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

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget _buildImageTextWidgets() {
    return Offstage(
      offstage: _isShowImageTextsWidget,
      child: Container(
        height: ScreenUtil().setHeight(292),
        width: ScreenUtil().uiSize.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _verticalImageText("images/icon_people_check.png","人口核查"),
            _verticalImageText("images/icon_house_check.png","房屋核查"),
            _verticalImageText("images/icon_task_manage.png","任务管理"),
            _verticalImageText("images/icon_intelligence_manage.png","情报管理"),
            _verticalImageText("images/icon_ajt.png","安居通")
          ],
        ),
      ),
    );
  }

  Widget _verticalImageText(String imageUrl,String textContent) {
    return Container(
      height: ScreenUtil().setHeight(196),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
           Image.asset(
             imageUrl,
             height: ScreenUtil().setHeight(116),
             width: ScreenUtil().setWidth(116),
             fit: BoxFit.contain,
           ),
          Positioned(
              top: ScreenUtil().setHeight(146),
              child: Text(textContent,style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Color.fromRGBO(34, 34, 34, 1)))
          )
        ],
      ),
    );
  }

  Widget _buildLineWidget() {
    return Container(
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().setHeight(24),
      color: Color.fromRGBO(247,248,250,1),
    );
  }

  Widget _buildMonitorWidget() {
    return Container(
      width: ScreenUtil().uiSize.width,
      height: ScreenUtil().setHeight(212),
      child: Stack(
        children: <Widget>[
          Positioned(
              top: ScreenUtil().setHeight(71),
              left: ScreenUtil().setWidth(41),
              child: Image.asset(
                  "images/icon_info.png",
                width: ScreenUtil().setWidth(64),
                height: ScreenUtil().setHeight(70),
              )
          ),
          Positioned(
              top: ScreenUtil().setHeight(48),
              left: ScreenUtil().setWidth(176),
              child: Text("督办提醒",style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(34, 34, 34, 1)))
          ),
          Positioned(
              top: ScreenUtil().setHeight(125),
              left: ScreenUtil().setWidth(176),
              child: Text("市局决定于7月8日开展专项整治行动",style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Color.fromRGBO(140,141,142,1)))
          )
        ],
      ),
    );
  }
  ///通知公告控件
  Widget _buildNoticeWidget() {
     return Container(
       width: ScreenUtil().uiSize.width,
       height: ScreenUtil().setHeight(120),
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.start,
         mainAxisSize: MainAxisSize.max,
         children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(32)),
                child: Text("公告",style: TextStyle(fontSize: ScreenUtil().setSp(44),color: Color.fromRGBO(215,57,49,1)))
            ),
           Padding(
               padding: EdgeInsets.only(left: ScreenUtil().setWidth(56),right: ScreenUtil().setWidth(38)),
               child: Text("8月26日，中国人民警察警旗授旗仪式在人民大...",
                   style: TextStyle(fontSize: ScreenUtil().setSp(40),
                   color: Color.fromRGBO(140,141,142,1)),
                   overflow:TextOverflow.ellipsis,
               )
           ),
         ],
       ),
     );
  }
}