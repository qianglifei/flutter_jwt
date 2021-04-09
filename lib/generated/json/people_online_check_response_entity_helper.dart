import 'package:jwt/main/first_page/people_online_check/people_online_check_response_entity.dart';

peopleOnlineCheckResponseEntityFromJson(PeopleOnlineCheckResponseEntity data, Map<String, dynamic> json) {
	if (json['returnCode'] != null) {
		data.returnCode = json['returnCode']?.toInt();
	}
	if (json['returnMsg'] != null) {
		data.returnMsg = json['returnMsg']?.toString();
	}
	if (json['returnData'] != null) {
		data.returnData = new PeopleOnlineCheckResponseReturnData().fromJson(json['returnData']);
	}
	if (json['returnStandAdder'] != null) {
		data.returnStandAdder = json['returnStandAdder']?.toString();
	}
	if (json['returnType'] != null) {
		data.returnType = json['returnType']?.toString();
	}
	return data;
}

Map<String, dynamic> peopleOnlineCheckResponseEntityToJson(PeopleOnlineCheckResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['returnCode'] = entity.returnCode;
	data['returnMsg'] = entity.returnMsg;
	if (entity.returnData != null) {
		data['returnData'] = entity.returnData.toJson();
	}
	data['returnStandAdder'] = entity.returnStandAdder;
	data['returnType'] = entity.returnType;
	return data;
}

peopleOnlineCheckResponseReturnDataFromJson(PeopleOnlineCheckResponseReturnData data, Map<String, dynamic> json) {
	if (json['bip_birthday'] != null) {
		data.bipBirthday = json['bip_birthday']?.toString();
	}
	if (json['bip_con_telephone'] != null) {
		data.bipConTelephone = json['bip_con_telephone']?.toString();
	}
	if (json['bip_nation'] != null) {
		data.bipNation = json['bip_nation']?.toString();
	}
	if (json['bip_rpr_address'] != null) {
		data.bipRprAddress = json['bip_rpr_address']?.toString();
	}
	if (json['bip_sfzhm'] != null) {
		data.bipSfzhm = json['bip_sfzhm']?.toString();
	}
	if (json['bip_xb'] != null) {
		data.bipXb = json['bip_xb']?.toString();
	}
	if (json['bip_xm'] != null) {
		data.bipXm = json['bip_xm']?.toString();
	}
	if (json['fwzjbxxdjb_fwzbh'] != null) {
		data.fwzjbxxdjbFwzbh = json['fwzjbxxdjb_fwzbh']?.toString();
	}
	if (json['fwzjbxxdjb_fwzmc'] != null) {
		data.fwzjbxxdjbFwzmc = json['fwzjbxxdjb_fwzmc']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}
	if (json['rdj_djrq'] != null) {
		data.rdjDjrq = json['rdj_djrq']?.toString();
	}
	if (json['rdj_grbh'] != null) {
		data.rdjGrbh = json['rdj_grbh']?.toString();
	}
	if (json['rdj_sspcsbm'] != null) {
		data.rdjSspcsbm = json['rdj_sspcsbm']?.toString();
	}
	if (json['rdj_sspcsmc'] != null) {
		data.rdjSspcsmc = json['rdj_sspcsmc']?.toString();
	}
	if (json['rld_glybm'] != null) {
		data.rldGlybm = json['rld_glybm']?.toString();
	}
	if (json['rld_glymc'] != null) {
		data.rldGlymc = json['rld_glymc']?.toString();
	}
	if (json['rzf_fwbh'] != null) {
		data.rzfFwbh = json['rzf_fwbh']?.toString();
	}
	if (json['rzf_sfbzdz'] != null) {
		data.rzfSfbzdz = json['rzf_sfbzdz']?.toString();
	}
	if (json['rzf_xzdxxdz'] != null) {
		data.rzfXzdxxdz = json['rzf_xzdxxdz']?.toString();
	}
	return data;
}

Map<String, dynamic> peopleOnlineCheckResponseReturnDataToJson(PeopleOnlineCheckResponseReturnData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bip_birthday'] = entity.bipBirthday;
	data['bip_con_telephone'] = entity.bipConTelephone;
	data['bip_nation'] = entity.bipNation;
	data['bip_rpr_address'] = entity.bipRprAddress;
	data['bip_sfzhm'] = entity.bipSfzhm;
	data['bip_xb'] = entity.bipXb;
	data['bip_xm'] = entity.bipXm;
	data['fwzjbxxdjb_fwzbh'] = entity.fwzjbxxdjbFwzbh;
	data['fwzjbxxdjb_fwzmc'] = entity.fwzjbxxdjbFwzmc;
	data['img'] = entity.img;
	data['rdj_djrq'] = entity.rdjDjrq;
	data['rdj_grbh'] = entity.rdjGrbh;
	data['rdj_sspcsbm'] = entity.rdjSspcsbm;
	data['rdj_sspcsmc'] = entity.rdjSspcsmc;
	data['rld_glybm'] = entity.rldGlybm;
	data['rld_glymc'] = entity.rldGlymc;
	data['rzf_fwbh'] = entity.rzfFwbh;
	data['rzf_sfbzdz'] = entity.rzfSfbzdz;
	data['rzf_xzdxxdz'] = entity.rzfXzdxxdz;
	return data;
}