
import 'package:flutter/material.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/entity/login_response_entity.dart';

class LoginRepository{
    static DioUtils _dioUtils = DioUtils.instance;
    /// 登录请求
    void loginRequest(Map<String,dynamic> requestBody)  {
      DioUtils.instance.postHttp<LoginResponseEntity>(
            url: URLConfig.LOGIN,
            method: DioUtils.POST,
            parameters:requestBody,
//            onSuccess: (data) {
//              print(data.toJson());
//              return data;
//            },
//            onError: (error){
//              print(error);
//              return error;
//            }
      ) as LoginResponseEntity;
    }

    Future<String> ss() async{
        await Future.delayed(Duration(seconds: 2));
        return "你好呀";
    }
}
