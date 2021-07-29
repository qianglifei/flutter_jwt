import 'package:jwt/main/team_management/team_choose/police_response_entity.dart';

policeResponseEntityFromJson(PoliceResponseEntity data, Map<String, dynamic> json) {
	if (json['mjxx'] != null) {
		data.mjxx = (json['mjxx'] as List).map((v) => PoliceResponseMjxx().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> policeResponseEntityToJson(PoliceResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['mjxx'] =  entity.mjxx?.map((v) => v.toJson())?.toList();
	return data;
}

policeResponseMjxxFromJson(PoliceResponseMjxx data, Map<String, dynamic> json) {
	if (json['mjxm'] != null) {
		data.mjxm = json['mjxm'].toString();
	}
	if (json['mjzh'] != null) {
		data.mjzh = json['mjzh'].toString();
	}
	return data;
}

Map<String, dynamic> policeResponseMjxxToJson(PoliceResponseMjxx entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['mjxm'] = entity.mjxm;
	data['mjzh'] = entity.mjzh;
	return data;
}