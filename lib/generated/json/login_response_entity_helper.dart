import 'package:jwt/entity/login_response_entity.dart';

loginResponseEntityFromJson(LoginResponseEntity data, Map<String, dynamic> json) {
	if (json['returnCode'] != null) {
		data.returnCode = json['returnCode']?.toInt();
	}
	if (json['returnMsg'] != null) {
		data.returnMsg = json['returnMsg']?.toString();
	}
	if (json['returnData'] != null) {
		data.returnData = new LoginResponseReturnData().fromJson(json['returnData']);
	}
	return data;
}

Map<String, dynamic> loginResponseEntityToJson(LoginResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['returnCode'] = entity.returnCode;
	data['returnMsg'] = entity.returnMsg;
	if (entity.returnData != null) {
		data['returnData'] = entity.returnData.toJson();
	}
	return data;
}

loginResponseReturnDataFromJson(LoginResponseReturnData data, Map<String, dynamic> json) {
	if (json['file_url'] != null) {
		data.fileUrl = json['file_url']?.toString();
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	if (json['user_cjsj'] != null) {
		data.userCjsj = json['user_cjsj']?.toString();
	}
	if (json['user_dwbm'] != null) {
		data.userDwbm = json['user_dwbm']?.toString();
	}
	if (json['user_gsdw'] != null) {
		data.userGsdw = json['user_gsdw']?.toString();
	}
	if (json['user_id'] != null) {
		data.userId = json['user_id']?.toString();
	}
	if (json['user_name'] != null) {
		data.userName = json['user_name']?.toString();
	}
	if (json['user_phone'] != null) {
		data.userPhone = json['user_phone']?.toString();
	}
	if (json['user_sfzhm'] != null) {
		data.userSfzhm = json['user_sfzhm']?.toString();
	}
	if (json['user_xgsj'] != null) {
		data.userXgsj = json['user_xgsj']?.toString();
	}
	if (json['user_xm'] != null) {
		data.userXm = json['user_xm']?.toString();
	}
	if (json['user_yhlx'] != null) {
		data.userYhlx = json['user_yhlx']?.toString();
	}
	if (json['user_zt'] != null) {
		data.userZt = json['user_zt']?.toString();
	}
	if (json['version'] != null) {
		data.version = json['version']?.toString();
	}
	return data;
}

Map<String, dynamic> loginResponseReturnDataToJson(LoginResponseReturnData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['file_url'] = entity.fileUrl;
	data['token'] = entity.token;
	data['user_cjsj'] = entity.userCjsj;
	data['user_dwbm'] = entity.userDwbm;
	data['user_gsdw'] = entity.userGsdw;
	data['user_id'] = entity.userId;
	data['user_name'] = entity.userName;
	data['user_phone'] = entity.userPhone;
	data['user_sfzhm'] = entity.userSfzhm;
	data['user_xgsj'] = entity.userXgsj;
	data['user_xm'] = entity.userXm;
	data['user_yhlx'] = entity.userYhlx;
	data['user_zt'] = entity.userZt;
	data['version'] = entity.version;
	return data;
}