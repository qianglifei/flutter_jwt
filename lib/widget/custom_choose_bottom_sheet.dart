import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/db/sql_manager.dart';
import 'package:jwt/entity/pcs_fwz_entity.dart';
typedef _CallBack  = void Function();
// ignore: must_be_immutable
class CustomChooseBottomSheet  extends StatefulWidget{
  String _title;
  String tableName;
  String pcsbm;
  _CallBack callBack;

  CustomChooseBottomSheet(this._title,{Key key,this.callBack,this.tableName,this.pcsbm}) : assert( _title != null);
  @override
  State<StatefulWidget> createState() => CustomChooseBottomSheetState();
}

class CustomChooseBottomSheetState extends State<CustomChooseBottomSheet> {
  List<PcsFwzEntity> _list = [];
  String _title = "";
  int position = 100000;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.tableName);
    print(widget.pcsbm);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  InkWell(
      child: Container(
        height: ScreenUtil().setHeight(144),
        width: ScreenUtil().uiSize.width,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: ScreenUtil().setHeight(47),
                left: ScreenUtil().setWidth(64),
                child: Text(widget._title,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
            ),
            Positioned(
                top: ScreenUtil().setHeight(47),
                right: ScreenUtil().setWidth(100),
                child: Text(widget._title,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
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
        print(widget.tableName);
        print(widget.pcsbm);
        print(_list);
        SqlManager.queryPCSOrFWZData(widget.tableName, widget.pcsbm).then((list){
          _list = list;
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
      },
    );
  }
}