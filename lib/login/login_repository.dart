
import 'package:flutter/material.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/entity/login_response_entity.dart';

class LoginRepository{
    static DioUtils _dioUtils = DioUtils.instance;
    /// 登录请求
    static Future loginRequest(Map<String,dynamic> requestBody) async{
       var postHttp = await _dioUtils.postHttp<LoginResponseEntity>(url: URLConfig.LOGIN, method: DioUtils.POST, parameters:requestBody);
       return postHttp;
    }

    Future<String> ss() async{
        await Future.delayed(Duration(seconds: 2));
        return "你好呀";
    }
}
