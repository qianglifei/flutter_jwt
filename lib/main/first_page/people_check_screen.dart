import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:jwt/entity/pcs_fwz_entity.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:jwt/widget/custom_button.dart';
import 'package:jwt/widget/custom_choose_widget.dart';
import 'package:jwt/widget/custom_input_widget.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SqlManager.copyDbFileToCacheDocument();

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
            child:CustomChooseWidget(
              "派出所",
              callBack: (){

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
            child: CustomChooseWidget(
                "服务站",
                callBack: (){
                  print("服务站被点击");
                  SqlManager.queryPCSData().then((list){
                      _list = list.cast<PcsFwzEntity>();
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context,state){ ///这里的state就是setState
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
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                            ),
                                            Text("选择派出所",style: TextStyle(fontSize: ScreenUtil().setSp(56),color: Color.fromRGBO(52,135,215,1))),
                                            InkWell(
                                              child: Text("确认",style: TextStyle(fontSize: ScreenUtil().setSp(56),color: Color.fromRGBO(52,135,215,1))),
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: ScreenUtil().setHeight(24),
                                        color: Color.fromRGBO(247,248,250,1),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: 40,
                                          itemBuilder: (BuildContext context, int index) {
                                            return GestureDetector(
                                              child: new Container(
                                                  color: position == index ? Color.fromRGBO(247,248,250,1) : Colors.white,
                                                  width: ScreenUtil().uiSize.width,
                                                  height: ScreenUtil().setHeight(144),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                          top: ScreenUtil().setHeight(40),
                                                          left: ScreenUtil().setWidth(64),
                                                          child: Text(_list[index].key,style: TextStyle(fontSize: ScreenUtil().setSp(44)))
                                                      ),
                                                      Positioned(
                                                          right: ScreenUtil().setWidth(64),
                                                          top: ScreenUtil().setHeight(45),
                                                          child: Offstage(
                                                            offstage: position == index ? false: true,
                                                            child: Image.asset("images/icon_select_true.png",
                                                              width: ScreenUtil().setWidth(48),
                                                              height: ScreenUtil().setHeight(32),
                                                              fit: BoxFit.contain,
                                                            ),
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              onTap: (){
                                                ///为了区分把setState改个名字
                                                state(() {
                                                  position = index;
                                                  _title = _list[position].key;
                                                  print(position);
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
                      ).then((vas) {
                        print(vas);
                      });
                  });
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
}