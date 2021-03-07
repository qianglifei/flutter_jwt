import 'dart:convert';

class NationEntity{
  String key;
  String value;
  NationEntity({this.key,this.value});

  factory NationEntity.fromJson(Map<String,dynamic> jsonMap){
    return NationEntity(
      key: jsonMap["CD_ID"],
      value: jsonMap["CD_NAME"]
    );
  }

  @override
  String toString() {
    return 'NationEntity{key: $key, value: $value}';
  }
}