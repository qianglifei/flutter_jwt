import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
///日志拦截器
class LogInterceptors extends InterceptorsWrapper{
  Dio dio;

  LogInterceptors(this.dio);

  @override
  Future onRequest(RequestOptions options) async {
    print("========================请求数据===================");
    //在请求之前做一些预处理，
    //我这边是在请求之前先把本地存储的SharedPreferences中把token 取出来 ，然后添加
    //dio.lock()是先锁定请求不发出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
    print('请求之前----');
    print("【请求baseUrl】${options.uri}");
    print("【请求参数】${options.data.toString()}");
    dio.lock();

    Future<dynamic> future = Future(()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.getString("token"));
      return prefs.getString("token");
    });

    return future.then((value) {
      options.headers["Authorization"] = value;
      return options;
    }).whenComplete(() => dio.unlock());

//    await SharedPreferencesUtils.getToken().then((token) {
//      if(token==null||token.toString().isEmpty){
//        return;
//      }
//      Map<String,String> parms = {"Authorization" : "Bearer "+token};
//      options.headers.addAll(parms);
//    });
//    dio.unlock();
//    return options;
//    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("【返回statusCode】${response.statusCode}");
    print("【返回data】${response.toString()}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("========================请求错误===================");
    formatError(err);
    return super.onError(err);
  }

  ///  error统一处理
  DioError formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      Fluttertoast.showToast(msg: "连接超时");
      print(e.hashCode.toString() + "连接超时");
      return e;
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      Fluttertoast.showToast(msg: "请求超时");
      print(e.hashCode.toString() + "请求超时");
      return e;
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      Fluttertoast.showToast(msg: "响应超时");
      print(e.hashCode.toString() + "响应超时");
      return e;
    } else if (e.type == DioErrorType.RESPONSE) {
      Fluttertoast.showToast(msg: "服务器异常");
      print(e.hashCode.toString() + "出现异常404 503");
      return e;
    } else if (e.type == DioErrorType.CANCEL) {
      Fluttertoast.showToast(msg: "请求取消");
      print(e.hashCode.toString() + "请求取消");
      return e;
    } else {
      Fluttertoast.
      showToast(
          msg: "网络连接失败",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 21
      );
      print("message =${e.message}");
      return e;
    }
  }
}