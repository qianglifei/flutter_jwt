import 'package:jwt/config/url_config.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/main/team_management/team_choose/police_response_entity.dart';

class PoliceRepository{
  static DioUtils _dioUtils = DioUtils.instance;
  /// 民警请求
  static Future policeRequest(Map<String,dynamic> requestBody) async{
    var postHttp = await _dioUtils.postHttp<PoliceResponseEntity>(url: URLConfig.POLICE_REQUEST, method: DioUtils.POST, parameters:requestBody);
    return postHttp;
  }
}