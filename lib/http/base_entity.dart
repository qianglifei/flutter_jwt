
import 'package:jwt/entity/entity_factory.dart';
import 'package:jwt/generated/json/base/json_convert_content.dart';

class BaseEntity<T>{
  int returnCode;
  String returnMsg;
  String returnStandAdder;
  String returnType;
  T returnData;
  BaseEntity({this.returnCode,this.returnMsg,this.returnData,this.returnStandAdder,this.returnType});

  BaseEntity.fromJson(Map<String, dynamic> json) {
    if (json['returnData'] != null&&json['returnData']!='null') {
      returnData = JsonConvert.fromJsonAsT<T>(json['returnData']);
    }
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
    returnStandAdder = json['returnStandAdder'];
    returnType = json["returnType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.returnData != null) {
      data['returnData'] = this.returnData;
    }
    data['returnCode'] = this.returnCode;
    data['returnMsg'] = this.returnMsg;
    data['returnStandAdder'] = this.returnStandAdder;
    data['returnType'] = this.returnType;
    return data;
  }
}