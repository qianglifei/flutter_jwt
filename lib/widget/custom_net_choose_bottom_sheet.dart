
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/entity/policeman_entity.dart';
import 'package:jwt/http/dio_utils.dart';

import 'loading_dialog.dart';

typedef CallBack = void Function(Policeman policeman);
typedef OnTab = void Function();
class CustomNetChooseBottomSheet extends StatefulWidget{

  List<Policeman> _list = [];
  String _title;
  CallBack callBack;
  OnTab onTab;
  CustomNetChooseBottomSheet(this._title,this._list,{this.callBack,this.onTab});
  @override
  State<StatefulWidget> createState() => CustomNetChooseBottomSheetState();
}

class CustomNetChooseBottomSheetState extends State<CustomNetChooseBottomSheet>{
  String _selectedContent;
  int position = 10000;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
        constraints: BoxConstraints(
          minHeight: ScreenUtil().setHeight(144),
          maxHeight: ScreenUtil().setHeight(500),
        ),
        width: ScreenUtil().uiSize.width,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(64)),
                child: Text(widget._title,style: TextStyle(fontSize: ScreenUtil().setSp(48),color: Color.fromRGBO(100,100,100,1)))
            ),
            Expanded(child: Text("")),
            Container(
                constraints: BoxConstraints(
                  minHeight: ScreenUtil().setHeight(144),
                  maxHeight: ScreenUtil().setHeight(500),
                  minWidth: ScreenUtil().setWidth(100),
                  maxWidth: ScreenUtil().setWidth(750),
                ),
                padding:EdgeInsets.only(left:10.0, right:0.0, top:14.0, bottom:8.0),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(24),right: ScreenUtil().setWidth(14)),
                child: Text(
                    _selectedContent ?? "请选择",
                    maxLines: 20,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(48),
                      color: Color.fromRGBO(100,100,100,1),
                    ))
            ),
            Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
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
        Map<String,dynamic> requestBody = new Map();
        requestBody.addAll({
          "pcsbh":widget._pcsbm,
        });
        DioUtils.instance.postHttps<Policeman>(
            url: URLConfig.POLICE_REQUEST,
            method: DioUtils.POST,
            parameters: requestBody,
            onSuccess: (data){
              LoadingDialog.dialogDismiss(context);
            },
            onError: (error){
              LoadingDialog.dialogDismiss(context);
            }
        );
          if(widget._list != null && widget._list.length > 0){
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                 Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child:Text("选择派出所",style: TextStyle(fontSize: ScreenUtil().setSp(56),color: Color.fromRGBO(52,135,215,1))),
                                    )
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
                                itemCount: widget._list.length,
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
                                                child: Text(widget._list[index].name,style: TextStyle(fontSize: ScreenUtil().setSp(44)))
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
                                      setState(() {
                                        position = index;
                                        _selectedContent = widget._list[position].name;
                                      });
                                      widget.callBack(widget._list[position]);
                                      Navigator.of(context).pop();
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
      }

      Widget _buildDialog(){
        return
      }
}