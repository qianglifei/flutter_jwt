import 'package:jwt/generated/json/base/json_convert_content.dart';

class PoliceResponseEntity with JsonConvert<PoliceResponseEntity> {
	List<PoliceResponseMjxx> mjxx;
}

class PoliceResponseMjxx with JsonConvert<PoliceResponseMjxx> {
	String mjxm;
	String mjzh;
}
