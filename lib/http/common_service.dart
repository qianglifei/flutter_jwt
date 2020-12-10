import 'package:dio/dio.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/entity/entity_factory.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/http/http_util.dart';
import 'dio_manager.dart';
import 'dart:convert';
class CommonService{
    HttpUtil _httpUtil = HttpUtil.getInstance();
    /// 登录接口
    void loginRequest(Function callBack,Map requestBody){
        Future<dynamic> future = _httpUtil.post(URLConfig.LOGIN,data: requestBody);
    }
  
  
    ///获取首页Banner数据
//    void getBannerList(Function callBack){
//       dio.
//       get(Api.FIRST_BANNER,options: new Options()).
//       then((response){
//         BannerDataEntity bannerDataEntity = EntityFactory.generateOBJ(response.data);
//         callBack(bannerDataEntity);
//         print(response.toString());
//       });
//    }
}