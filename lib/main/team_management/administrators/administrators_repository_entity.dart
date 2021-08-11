import 'package:jwt/config/url_config.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/main/team_management/team_choose/police_response_entity.dart';

class AdministratorsRepository{
  static DioUtils _dioUtils = DioUtils.instance;
  ///管理员列表
  static Future administratorsRequest(Map<String,dynamic> requestBody) async{
    var postHttp = await _dioUtils.postHttp<PoliceResponseEntity>(url: URLConfig.sgylbcx, method: DioUtils.POST, parameters:requestBody);
    return postHttp;
  }

}