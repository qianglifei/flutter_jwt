import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt/base/base_widget.dart';
import 'package:jwt/login/login_bloc.dart';
import 'package:jwt/login/login_screen.dart';
import 'package:jwt/main/app.dart';
import 'package:jwt/widget/custom_app_bar.dart';
import 'package:lcfarm_flutter_umeng/lcfarm_flutter_umeng.dart';

// ignore: must_be_immutable
class SplashScreen extends BaseWidget{
  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return new SplashScreenState();
  }
}

class SplashScreenState extends BaseWidgetState<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LcfarmFlutterUmeng.init(
        iOSAppKey: "60b0651add01c71b57c8c0ed",
        androidAppKey: "60b064a56c421a3d97d05e3a",
        channel: "cps_1.1.0",
        logEnable: true
    );
    Future.delayed(Duration(seconds: 2),(){

        Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context){
          return BlocProvider(
            create: (context)=> LoginBloc(),
            child: LoginScreen()
          );
        }), (route) => route == null);
    });
  }

  @override
  CustomAppBar getAppBar() {
    // TODO: implement getAppBar
    return null;
  }

  @override
  Widget getContentWidget(BuildContext context) {
    // TODO: implement getContentWidget
    //默认 width : 1080px , height:1920px , allowFontScaling:false
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context);
    ScreenUtil.init(context,designSize: Size(1080, 1920));
    ScreenUtil.init(context,designSize: Size(1080, 1920),allowFontScaling: true);
    //假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    //ScreenUtil.init(context, designSize: Size(750, 1334));
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
    //ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    printScreenInformation();
    return Container(
      child: Image.asset(
        "images/icon_splash_gb.png",
        fit: BoxFit.fitHeight,
        //无限大
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  @override
  void onClickErrorWidget() {
    // TODO: implement onClickErrorWidget
  }

  /// 打印屏幕信息
  void printScreenInformation() {
    print('设备宽度:${ScreenUtil().screenWidth}'); //Device width
    print('设备高度:${ScreenUtil().screenHeight}'); //Device height
    print('设备的像素密度:${ScreenUtil().pixelRatio}'); //Device pixel density
    print(
      '底部安全区距离:${ScreenUtil().bottomBarHeight}dp',
    ); //Bottom safe zone distance，suitable for buttons with full screen
    print(
      '状态栏高度:${ScreenUtil().statusBarHeight}dp',
    ); //Status bar height , Notch will be higher Unit px

    print('实际宽度的dp与设计稿px的比例:${ScreenUtil().scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}');

    print(
      '宽度和字体相对于设计稿放大的比例:${ScreenUtil().scaleWidth * ScreenUtil().pixelRatio}',
    );
    print(
      '高度相对于设计稿放大的比例:${ScreenUtil().scaleHeight * ScreenUtil().pixelRatio}',
    );
    print('系统的字体缩放比例:${ScreenUtil().textScaleFactor}');

    print('屏幕宽度的0.5:${0.5.sw}');
    print('屏幕高度的0.5:${0.5.sh}');
  }
}