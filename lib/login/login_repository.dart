import 'package:flutter/material.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/entity/login_response_entity.dart';

class LoginRepository{
  static DioUtils _dioUtils = DioUtils.instance;

    /// 登录请求
    static void loginRequest(Map<String,dynamic> requestBody) {

       print("你的世界，我曾今来过");
    }
}
