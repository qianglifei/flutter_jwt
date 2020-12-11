import 'package:jwt/generated/json/base/json_convert_content.dart';
import 'package:jwt/generated/json/base/json_field.dart';

class LoginResponseEntity with JsonConvert<LoginResponseEntity> {
	@JSONField(name: "file_url")
	String fileUrl;
	String token;
	@JSONField(name: "user_cjsj")
	String userCjsj;
	@JSONField(name: "user_dwbm")
	String userDwbm;
	@JSONField(name: "user_gsdw")
	String userGsdw;
	@JSONField(name: "user_id")
	String userId;
	@JSONField(name: "user_name")
	String userName;
	@JSONField(name: "user_phone")
	String userPhone;
	@JSONField(name: "user_sfzhm")
	String userSfzhm;
	@JSONField(name: "user_xgsj")
	String userXgsj;
	@JSONField(name: "user_xm")
	String userXm;
	@JSONField(name: "user_yhlx")
	String userYhlx;
	@JSONField(name: "user_zt")
	String userZt;
	String version;

}
