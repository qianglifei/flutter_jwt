import 'package:flutter/material.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/entity/login_response_entity.dart';

class LoginRepository{
    /// 登录请求
    // ignore: missing_return
    static Future<LoginResponseEntity> loginRequest(Map<String,dynamic> requestBody) async{
      DioUtils.instance.postHttp<LoginResponseEntity>(
          url: URLConfig.LOGIN ,
          method: DioUtils.POST,
          parameters:requestBody,
          onSuccess: (data){
              return  data;
          },
          onError: (error){
              return error;
          }
      );
    }
}
