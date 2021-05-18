import 'package:jwt/config/url_config.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/http/dio_utils.dart';

class PeopleCheckSubmitRepository{
    static DioUtils _dioUtils = DioUtils.instance;
    /// 提交请求
    static Future peopleCheckSubmitRequest(Map<String,dynamic> requestBody) async{
       var responseBody = await _dioUtils.postHttp<LoginResponseEntity>(url: URLConfig.RYHCTJ,method: DioUtils.POST,parameters: requestBody);
       return responseBody;
    }
}