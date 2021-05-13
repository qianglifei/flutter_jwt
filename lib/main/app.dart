import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:jwt/main/first_page/homepage_screen.dart';
import 'package:jwt/main/information_check/Info_check_screen.dart';
import 'package:jwt/main/mine_page/mine_screen.dart';
import 'package:jwt/main/team_management/team_management_screen.dart';
/// 应用页面使用有状态的widget
class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppState();
  }
}
/// 应用页面状态实现类
class AppState extends State<App> {
  //当前选中项的索引
  int _selectedIndex = 0;
  var lastPopTime;
  final appBarTitles = ["首页","信息核查","队伍管理","我的"];
  var pages = <Widget>[
      HomepageScreen(),
      InfoCheckScreen(),
      TeamManagementScreen(),
      MineScreen()
  ];

  int elevation = 4;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //双击退出组件
    return WillPopScope(
        //布局容器控件
        child: Scaffold(
          appBar: null,
          ///  这个 Widget 的作用和 Stack 非常类似，唯一的区别是如果你有三个 child Widget，
          ///  那么它的布局行为是显示你指定的第index个 child Widget ，其他 child Widget 不可见。
          body: new IndexedStack(index: _selectedIndex,children: pages),
          /// 底部导航栏
          bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                buildBottomNavigationWidget("首页","images/icon_bottom_sy.png","images/icon_bottom_sy_pressed.png"),
                buildBottomNavigationWidget("信息核查","images/icon_bottom_rfcx.png","images/icon_bottom_rfcx_pressed.png"),
                buildBottomNavigationWidget("队伍管理","images/icon_bottom_yj.png","images/icon_bottom_yj_pressed.png"),
                buildBottomNavigationWidget("我的","images/icon_bottom_wd.png","images/icon_bottom_wd_pressed.png")
              ],
              //设置显示模式
              type: BottomNavigationBarType.fixed,
              //显示当前索引
              currentIndex: _selectedIndex,
              //底部导航栏的点击事件处理
              onTap: _onItemTapped,
          ),
        ),
        onWillPop: () async {
          if (lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            lastPopTime = DateTime.now();
            return new Future.value(false);
          }
          return new Future.value(true);
        },
    );
  }

  BottomNavigationBarItem buildBottomNavigationWidget(String title,String iconUrl,String activeIconUrl) {
    return BottomNavigationBarItem(
        icon: Image.asset(
            iconUrl,
            width: ScreenUtil().setWidth(64),
            height: ScreenUtil().setHeight(64),
            fit: BoxFit.contain,
        ),
        activeIcon: Image.asset(
           activeIconUrl,
           width: ScreenUtil().setWidth(64),
           height: ScreenUtil().setHeight(64),
          fit: BoxFit.contain,
        ),
        title: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(30,allowFontScalingSelf: true)))
    );
  }

  ///选择按下处理，设置当前索引，为index值
  void _onItemTapped(int value) {
    setState(() {
        _selectedIndex = value;
        if(value == 4 || value == 2){
          elevation = 0;
        }else{
          elevation = 4;
        }
    });
  }
}