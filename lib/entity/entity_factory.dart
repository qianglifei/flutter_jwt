import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_response_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "LoginResponseEntity") {
      return LoginResponseEntity().fromJson(json) as T;
    }else if(T.toString() == "PeopleOnlineCheckResponseEntity"){
      return PeopleOnlineCheckResponseEntity().fromJson(json) as T;
    }
  }
}
