import 'package:jwt/generated/json/base/json_convert_content.dart';
import 'package:jwt/generated/json/base/json_field.dart';

class PeopleOnlineCheckResponseEntity with JsonConvert<PeopleOnlineCheckResponseEntity> {
	int returnCode;
	String returnMsg;
	PeopleOnlineCheckResponseReturnData returnData;
	String returnStandAdder;
	String returnType;
}

class PeopleOnlineCheckResponseReturnData with JsonConvert<PeopleOnlineCheckResponseReturnData> {
	@JSONField(name: "bip_birthday")
	String bipBirthday;
	@JSONField(name: "bip_con_telephone")
	String bipConTelephone;
	@JSONField(name: "bip_nation")
	String bipNation;
	@JSONField(name: "bip_rpr_address")
	String bipRprAddress;
	@JSONField(name: "bip_sfzhm")
	String bipSfzhm;
	@JSONField(name: "bip_xb")
	String bipXb;
	@JSONField(name: "bip_xm")
	String bipXm;
	@JSONField(name: "fwzjbxxdjb_fwzbh")
	String fwzjbxxdjbFwzbh;
	@JSONField(name: "fwzjbxxdjb_fwzmc")
	String fwzjbxxdjbFwzmc;
	String img;
	@JSONField(name: "rdj_djrq")
	String rdjDjrq;
	@JSONField(name: "rdj_grbh")
	String rdjGrbh;
	@JSONField(name: "rdj_sspcsbm")
	String rdjSspcsbm;
	@JSONField(name: "rdj_sspcsmc")
	String rdjSspcsmc;
	@JSONField(name: "rld_glybm")
	String rldGlybm;
	@JSONField(name: "rld_glymc")
	String rldGlymc;
	@JSONField(name: "rzf_fwbh")
	String rzfFwbh;
	@JSONField(name: "rzf_sfbzdz")
	String rzfSfbzdz;
	@JSONField(name: "rzf_xzdxxdz")
	String rzfXzdxxdz;


	@override
  String toString() {
    return 'PeopleOnlineCheckResponseReturnData{bipBirthday: $bipBirthday, bipConTelephone: $bipConTelephone, bipNation: $bipNation, bipRprAddress: $bipRprAddress, bipSfzhm: $bipSfzhm, bipXb: $bipXb, bipXm: $bipXm, fwzjbxxdjbFwzbh: $fwzjbxxdjbFwzbh, fwzjbxxdjbFwzmc: $fwzjbxxdjbFwzmc, img: $img, rdjDjrq: $rdjDjrq, rdjGrbh: $rdjGrbh, rdjSspcsbm: $rdjSspcsbm, rdjSspcsmc: $rdjSspcsmc, rldGlybm: $rldGlybm, rldGlymc: $rldGlymc, rzfFwbh: $rzfFwbh, rzfSfbzdz: $rzfSfbzdz, rzfXzdxxdz: $rzfXzdxxdz}';
  }
}
