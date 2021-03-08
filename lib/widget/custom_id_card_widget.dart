import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:jwt/main/first_page/people_online_check/nation_entity.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_bloc.dart';

typedef CallBack = void Function(String value);

// ignore: must_be_immutable
class CustomIDCard extends StatefulWidget{
  CallBack callBack;
  PeopleOnlineCheckBloc peopleOnlineCheckBloc;
  CustomIDCard({this.callBack ,this.peopleOnlineCheckBloc});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomIDCardState();
  }

}

class CustomIDCardState extends State<CustomIDCard> {
  //姓名控制器
  TextEditingController nameController = TextEditingController();
  //户籍地址控制器
  TextEditingController residenceAddressController = TextEditingController();
  //民族列表
  List<NationEntity> _list;
  String _title = "";
  String _selectedContent = "请选择";
  int position = 100000;
  @override
  Widget build(BuildContext context) {
     return BlocBuilder<PeopleOnlineCheckBloc,PeopleOnlineCheckState>(
         builder: (context,state){
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
                   child: _buildInputTextWidget("姓        名"),
                 ),
                 Positioned(
                   child: _buildTextWidget("证件号码"),
                   top: ScreenUtil().setHeight(100),
                 ),
                 Positioned(
                   child: _buildTextWidget("出生日期"),
                   top: ScreenUtil().setHeight(200),
                 ),
                 Positioned(
                   child: _buildChooseTextWidget("民        族"),
                   top: ScreenUtil().setHeight(300),
                 ),
                 Positioned(
                   child: _buildInputTextWidget("户籍地址"),
                   top: ScreenUtil().setHeight(400),
                 ),
                 Positioned(
                   top: ScreenUtil().setHeight(25),
                   right: ScreenUtil().setWidth(47),
                   child: Image.asset(
                     "images/icon_head.png",
                     width: ScreenUtil().setWidth(260),
                     height: ScreenUtil().setHeight(320),
                     fit: BoxFit.contain,
                   ),
                 ),
                 Positioned(
                   top: ScreenUtil().setHeight(290),
                   right: ScreenUtil().setWidth(47),
                   child: Image.asset(
                     "images/icon_register.png",
                     width: ScreenUtil().setWidth(260),
                     height: ScreenUtil().setHeight(320),
                     fit: BoxFit.contain,
                   ),
                 ),
               ],
             ),
           );
         }
     );

  }

 //横排多个文本显示输入widget
 Widget _buildInputTextWidget(String title) {
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
              color: Colors.cyan,
              width: ScreenUtil().setWidth(460),
              child: TextField(
                autofocus: false,
                controller: nameController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true)),
                decoration: InputDecoration(
                  fillColor: Colors.cyan,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  hintText: "请输入姓名",
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }

  //横排多个文本显示widget
  Widget _buildTextWidget(String title) {
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
            child: Text("",
                style: TextStyle(
                    color: Color.fromRGBO(42, 168, 245, 1),
                    fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true)
                )
            ),
          ),
        ],
      ),
    );
  }

  //横排文本选择widget
  Widget _buildChooseTextWidget(String title) {
    return BlocBuilder<PeopleOnlineCheckBloc,PeopleOnlineCheckState>(
        builder: (context,state){
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
                    child: GestureDetector(
                      child: Text("选择民族", style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: ScreenUtil().setSp(40,allowFontScalingSelf: true)
                      )
                      ),
                      onTap: (){
                        print("选择民族");
                        SqlManager.queryNationData().then((list) {
                          _list = list;
                          if(_list != null){
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
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
                                                      //添加选择事件
                                                      BlocProvider.of<PeopleOnlineCheckBloc>(context).add(NationSureEvent(nationSure: _selectedContent));
//                                                      setState(() {
//                                                        // ignore: unnecessary_statements
//                                                        _selectedContent;
//
//                                                      });
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
                                                itemCount: _list.length,
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
                                                                child: Text(_list[index].value,style: TextStyle(fontSize: ScreenUtil().setSp(44)))
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
                                                        _title = _list[position].value;
                                                        print(_title);
                                                        print(_list[position].value);
                                                        _selectedContent = _list[position].value;
                                                        if(widget.callBack != null && _list[position].value != null){
                                                          widget.callBack( _list[position].key);
                                                        }
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
                          }
                        });
                      },
                    )
                ),
              ],
            ),
          );
        }
    );

  }
}