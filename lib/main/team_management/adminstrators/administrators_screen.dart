
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/main/team_management/adminstrators/administrators_bloc.dart';
import 'package:jwt/widget/custom_app_bar.dart';

class AdministratorsScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return AdministratorsScreenState();
  }

}

class AdministratorsScreenState extends BaseWidgetState<AdministratorsScreen>{
  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return CustomAppBar(
        child: BaseTitleAppBar(
          "实管员列表",
          isShowLeftBackIcon: true,
          isShowRightWidget: false,
        )
    );
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
     return BlocBuilder<AdministratorsBloc,AdministratorsState>(
         builder: (context,state){
           return Column(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               _searchBar(),
               Expanded(
                 child: ListView.separated(
                   itemCount: 50,
                   itemBuilder: (BuildContext context,int index){
                     return GestureDetector(
                        child: Container(
                          width: ScreenUtil().screenWidth,
                          height: ScreenUtil().setHeight(228),
                          child: Stack(
                            children: [
                              Positioned(
                                  left: ScreenUtil().setWidth(64),
                                  top: ScreenUtil().setHeight(37),
                                  child: Text(
                                    "王明明",
                                    style: TextStyle(
                                      color: Color.fromRGBO(34,34,34,1),
                                      fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
                                    ),
                                  )
                              ),
                              Positioned(
                                  left: ScreenUtil().setWidth(241),
                                  top: ScreenUtil().setHeight(40),
                                  child: Text(
                                    "(男 | 汉族)",
                                    style: TextStyle(
                                      color: Color.fromRGBO(34,34,34,1),
                                      fontSize: ScreenUtil().setSp(42,allowFontScalingSelf: true),
                                    ),
                                  )
                              ),
                              Positioned(
                                  left: ScreenUtil().setWidth(64),
                                  bottom: ScreenUtil().setHeight(33),
                                  child: Text(
                                    "身份证号",
                                    style: TextStyle(
                                      color: Color.fromRGBO(140,141,142,1),
                                      fontSize: ScreenUtil().setSp(42,allowFontScalingSelf: true),
                                    ),
                                  )
                              ),
                              Positioned(
                                  left: ScreenUtil().setWidth(288),
                                  bottom: ScreenUtil().setHeight(33),
                                  child: Text(
                                    "130725199201121614",
                                    style: TextStyle(
                                      color: Color.fromRGBO(100,100,100,1),
                                      fontSize: ScreenUtil().setSp(42,allowFontScalingSelf: true),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        onTap: (){

                        },
                     );
                   },
                   separatorBuilder: (BuildContext context, int index){
                     return Container(
                        color: Color.fromRGBO(245,247,255,1),
                        width: ScreenUtil().screenWidth,
                        height: ScreenUtil().setHeight(24),
                     );
                   },
                   shrinkWrap: true,
                 ),
               ),
             ],
           );
         }
     );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget _searchBar() {
    return Container(
      color: Color.fromRGBO(245,247,255,1),
      height: ScreenUtil().setHeight(134),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            child: Container(
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(70),
                height: ScreenUtil().setHeight(90),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(32),right: ScreenUtil().setWidth(32)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Color.fromRGBO(232,235,246,1)
                      ),
                    ),
                    Positioned(
                        left: 8,
                        child: Image.asset(
                          "images/icon_sousuo.png",
                          height: ScreenUtil().setWidth(48),
                          width: ScreenUtil().setHeight(48),
                          fit: BoxFit.cover,
                        )
                    ),
                    Positioned(
                      left: 40,
                      child: Text("搜索关键词，关键字",style: TextStyle(color: Colors.white,fontSize: 18)),
                    ),
                    Positioned(
                        right: 15,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Image.asset(
                            "images/icon_close.png",
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                          onTap: (){
                            Fluttertoast.showToast(msg: "扫一扫");
                          },
                        )
                    ),

                  ],
                )
            ),
            onTap: (){
              Fluttertoast.showToast(msg: "搜索");
            },
          ),
        ],
      ),
    );
  }
}