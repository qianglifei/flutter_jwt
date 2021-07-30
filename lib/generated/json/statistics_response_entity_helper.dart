import 'package:jwt/main/team_management/team_choose/statistics_response_entity.dart';

statisticsResponseEntityFromJson(StatisticsResponseEntity data, Map<String, dynamic> json) {
	if (json['bzdzhxzh'] != null) {
		data.bzdzhxzh = json['bzdzhxzh'].toString();
	}
	if (json['bzfw'] != null) {
		data.bzfw = json['bzfw'].toString();
	}
	if (json['bzrk'] != null) {
		data.bzrk = json['bzrk'].toString();
	}
	if (json['czfws'] != null) {
		data.czfws = json['czfws'].toString();
	}
	if (json['fwbg'] != null) {
		data.fwbg = json['fwbg'].toString();
	}
	if (json['fwlr'] != null) {
		data.fwlr = json['fwlr'].toString();
	}
	if (json['fwzx'] != null) {
		data.fwzx = json['fwzx'].toString();
	}
	if (json['gxqy'] != null) {
		data.gxqy = json['gxqy'].toString();
	}
	if (json['gzlhj'] != null) {
		data.gzlhj = json['gzlhj'].toString();
	}
	if (json['hjrks'] != null) {
		data.hjrks = json['hjrks'].toString();
	}
	if (json['jwrys'] != null) {
		data.jwrys = json['jwrys'].toString();
	}
	if (json['ldrks'] != null) {
		data.ldrks = json['ldrks'].toString();
	}
	if (json['qzsgys'] != null) {
		data.qzsgys = json['qzsgys'].toString();
	}
	if (json['rybg'] != null) {
		data.rybg = json['rybg'].toString();
	}
	if (json['rylr'] != null) {
		data.rylr = json['rylr'].toString();
	}
	if (json['ryqy'] != null) {
		data.ryqy = json['ryqy'].toString();
	}
	if (json['ryzx'] != null) {
		data.ryzx = json['ryzx'].toString();
	}
	if (json['user_czsj'] != null) {
		data.userCzsj = json['user_czsj'].toString();
	}
	if (json['zfws'] != null) {
		data.zfws = json['zfws'].toString();
	}
	if (json['zrks'] != null) {
		data.zrks = json['zrks'].toString();
	}
	if (json['zzfws'] != null) {
		data.zzfws = json['zzfws'].toString();
	}
	return data;
}

Map<String, dynamic> statisticsResponseEntityToJson(StatisticsResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bzdzhxzh'] = entity.bzdzhxzh;
	data['bzfw'] = entity.bzfw;
	data['bzrk'] = entity.bzrk;
	data['czfws'] = entity.czfws;
	data['fwbg'] = entity.fwbg;
	data['fwlr'] = entity.fwlr;
	data['fwzx'] = entity.fwzx;
	data['gxqy'] = entity.gxqy;
	data['gzlhj'] = entity.gzlhj;
	data['hjrks'] = entity.hjrks;
	data['jwrys'] = entity.jwrys;
	data['ldrks'] = entity.ldrks;
	data['qzsgys'] = entity.qzsgys;
	data['rybg'] = entity.rybg;
	data['rylr'] = entity.rylr;
	data['ryqy'] = entity.ryqy;
	data['ryzx'] = entity.ryzx;
	data['user_czsj'] = entity.userCzsj;
	data['zfws'] = entity.zfws;
	data['zrks'] = entity.zrks;
	data['zzfws'] = entity.zzfws;
	return data;
}