
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt/base/base_app_bar.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/main/team_management/administrators/administrators_bloc.dart';
import 'package:jwt/widget/custom_app_bar.dart';

class AdministratorsScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return AdministratorsScreenState();
  }

}

class AdministratorsScreenState extends BaseWidgetState<AdministratorsScreen>{
  TextEditingController controller = TextEditingController();
  String _searchContent = "";
  String _policeCode = "";
  String _policemanCode = "";
  // EasyRefreshController _controller;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = EasyRefreshController();
    requestAdministrators();
  }

  void requestAdministrators(){
    Map<String,dynamic> requestBody = Map.from({});
    requestBody.addAll({
      "pcsbh":_policeCode,
      "mjzh":_policemanCode,
      "data":_searchContent
    });
    BlocProvider.of<AdministratorsBloc>(context).add(AdministratorsRequestEvent(requestBody: requestBody));
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
               _buildListView()
             ],
           );
         }
     );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  Widget _buildListView(){
    return Expanded(
      child: EasyRefresh(
          enableControlFinishRefresh: true,
          enableControlFinishLoad: false,
          header: PhoenixHeader(),   //头部刷新
          footer: TaurusFooter(),    //底部刷新
          onRefresh: () async{
            //下拉请求新数据
          },
          onLoad: () async {
            //下拉增加新数据
          },
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
    );
  }


  Widget _searchBar() {
    return Container(
      color: Color.fromRGBO(245,247,255,1),
      height: ScreenUtil().setHeight(144),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(64),
            height: ScreenUtil().setHeight(96),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(238, 242, 248, 0.6)),
                borderRadius: BorderRadius.circular(35.0)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  child:Image.asset(
                    "images/icon_sousuo.png",
                    width: ScreenUtil().setWidth(48),
                    height: ScreenUtil().setHeight(48),
                    fit: BoxFit.cover,
                  ),
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                ),
                Container(
                  width: MediaQuery.of(context).size.width- 100,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child:TextField(
                    controller: controller,
                    textAlign: TextAlign.left,
//                        decoration:  InputDecoration.collapsed(
//                          hintText: "搜索",
//                          border: InputBorder.none,
//                          style: TextStyle(textBaseline: TextBaseline.alphabetic),
//                        ),
                    decoration: InputDecoration(
                      //这行代码是关键，设置这个之后，居中
                        contentPadding: EdgeInsets.only(bottom: 12),
                        hintText: '请输入实管员姓名',suffixStyle: TextStyle(fontSize: ScreenUtil().setSp(42)),
                        border:InputBorder.none
                    ),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    //提交按钮(搜索/回车/确认)
                    onSubmitted: (text){
                       requestAdministrators();
                    },
                  ),
                ),
                Padding(
                  child:GestureDetector(
                    child: Image.asset(
                      "images/icon_close.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    onTap: (){
                      controller.clear();
                    },
                  ),
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}