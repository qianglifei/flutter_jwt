
import 'package:jwt/entity/entity_factory.dart';
import 'package:jwt/generated/json/base/json_convert_content.dart';

class BaseEntity<T>{
  int returnCode;
  String returnMsg;
  T returnData;
  BaseEntity({this.returnCode,this.returnMsg,this.returnData});

  BaseEntity.fromJson(Map<String, dynamic> json) {
    if (json['returnData'] != null&&json['returnData']!='null') {
      returnData = JsonConvert.fromJsonAsT<T>(json['returnData']);
    }
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.returnData != null) {
      data['returnData'] = this.returnData;
    }
    data['returnCode'] = this.returnCode;
    data['returnMsg'] = this.returnMsg;
    return data;
  }
}