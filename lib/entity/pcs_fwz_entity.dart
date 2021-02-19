
class PcsFwzEntity{
  String key;
  String value;

  PcsFwzEntity({this.value,this.key});

  factory PcsFwzEntity.fromJson(Map<String,dynamic> json){
    return PcsFwzEntity(
        key : json["PCSBH"],
        value : json["PCSMC"]
    );
  }

  @override
  String toString() {
    return 'PcsFwzEntity{_key: $key, _value: $value}';
  }
}