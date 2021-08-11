import 'package:jwt/main/team_management/administrators/administrators_response_entity.dart';

administratorsResponseEntityFromJson(AdministratorsResponseEntity data, Map<String, dynamic> json) {
	if (json['sgyxx'] != null) {
		data.sgyxx = (json['sgyxx'] as List).map((v) => AdministratorsResponseSgyxx().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> administratorsResponseEntityToJson(AdministratorsResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sgyxx'] =  entity.sgyxx?.map((v) => v.toJson())?.toList();
	return data;
}

administratorsResponseSgyxxFromJson(AdministratorsResponseSgyxx data, Map<String, dynamic> json) {
	if (json['glyjbxxdjb_glybm'] != null) {
		data.glyjbxxdjbGlybm = json['glyjbxxdjb_glybm'].toString();
	}
	if (json['glyjbxxdjb_glyxm'] != null) {
		data.glyjbxxdjbGlyxm = json['glyjbxxdjb_glyxm'].toString();
	}
	if (json['glyjbxxdjb_mz'] != null) {
		data.glyjbxxdjbMz = json['glyjbxxdjb_mz'].toString();
	}
	if (json['glyjbxxdjb_sfzhm'] != null) {
		data.glyjbxxdjbSfzhm = json['glyjbxxdjb_sfzhm'].toString();
	}
	if (json['glyjbxxdjb_xb'] != null) {
		data.glyjbxxdjbXb = json['glyjbxxdjb_xb'].toString();
	}
	return data;
}

Map<String, dynamic> administratorsResponseSgyxxToJson(AdministratorsResponseSgyxx entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['glyjbxxdjb_glybm'] = entity.glyjbxxdjbGlybm;
	data['glyjbxxdjb_glyxm'] = entity.glyjbxxdjbGlyxm;
	data['glyjbxxdjb_mz'] = entity.glyjbxxdjbMz;
	data['glyjbxxdjb_sfzhm'] = entity.glyjbxxdjbSfzhm;
	data['glyjbxxdjb_xb'] = entity.glyjbxxdjbXb;
	return data;
}