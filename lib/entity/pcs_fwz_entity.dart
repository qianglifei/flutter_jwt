
class PcsFwzEntity{
  String key;
  String value;

  PcsFwzEntity({this.value,this.key});

  factory PcsFwzEntity.fromJson(Map<String,dynamic> json,String tableName){
    return tableName == "PCSFWZDID_ONLY" ?
    PcsFwzEntity(
        key : json["PCSBH"],
        value : json["PCSMC"]
    ):
    PcsFwzEntity(
        key : json["FWZJBXXDJB_FWZBH"],
        value : json["FWZJBXXDJB_MC"]
    );
  }

  @override
  String toString() {
    return 'PcsFwzEntity{_key: $key, _value: $value}';
  }
}