
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt/splash/splash_screen.dart';

void main() {
  runApp(MyApp());

  if(Platform.isAndroid){
    ///设置Android状态栏为透明的沉浸，写在组件渲染之后
    ///是为了在渲染后进行set赋值，覆盖状态栏，如果写在渲染之前MaterialApp组件会覆盖掉这个值
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  if(Platform.isIOS){
    ///设置ios 状态栏为透明的沉浸，写在组件渲染之后
    ///是为了在渲染后进行set赋值，覆盖状态栏，
    ///如果写在渲染之前MaterialApp组件会覆盖掉这个值
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 除半透明状态栏
    if (Theme.of(context).platform == TargetPlatform.android) {
      // android 平台
      SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(_style);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      // 设置这一属性即可,去掉 右上角的标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

      ),
      home: SplashScreen(),
//      ///应用程序的顶级路由表
//      routes: ,
    );
  }
}
