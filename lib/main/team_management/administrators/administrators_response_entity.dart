import 'package:jwt/generated/json/base/json_convert_content.dart';
import 'package:jwt/generated/json/base/json_field.dart';

class AdministratorsResponseEntity with JsonConvert<AdministratorsResponseEntity> {
	List<AdministratorsResponseSgyxx> sgyxx;
}

class AdministratorsResponseSgyxx with JsonConvert<AdministratorsResponseSgyxx> {
	@JSONField(name: "glyjbxxdjb_glybm")
	String glyjbxxdjbGlybm;
	@JSONField(name: "glyjbxxdjb_glyxm")
	String glyjbxxdjbGlyxm;
	@JSONField(name: "glyjbxxdjb_mz")
	String glyjbxxdjbMz;
	@JSONField(name: "glyjbxxdjb_sfzhm")
	String glyjbxxdjbSfzhm;
	@JSONField(name: "glyjbxxdjb_xb")
	String glyjbxxdjbXb;
}
