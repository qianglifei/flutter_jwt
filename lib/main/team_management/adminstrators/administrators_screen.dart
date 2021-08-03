
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
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
     return Container(
       child: Text("实管员列表"),
     );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget _searchBar() {
    return Container(
      color: Colors.transparent,
      height: 110,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // GestureDetector(
          //   behavior: HitTestBehavior.opaque,
          //   child: Image.asset(
          //     "images/kefubai.png",
          //     height: 33,
          //     width: 31,
          //     fit: BoxFit.cover,
          //   ),
          //   onTap: (){
          //     Fluttertoast.showToast(msg: "智能机器人");
          //   },
          // ),

          GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 35,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color.fromRGBO(255, 255, 255, 0.6)
                      ),
                    ),
                    Positioned(
                        left: 8,
                        child: Image.asset(
                          "images/sousuo.png",
                          height: 25,
                          width: 25,
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
                            "images/saoyisao.png",
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
          // Container(
          //     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //     child: GestureDetector(
          //       behavior: HitTestBehavior.translucent,
          //       child:Image.asset(
          //         "images/xiaoxi.png",
          //         height: 30,
          //         width: 30,
          //         fit: BoxFit.cover,
          //       ),
          //       onTap: (){
          //         Fluttertoast.showToast(msg: "消息");
          //       },
          //     )
          // )
        ],
      ),
    );
  }
}