
class PcsFwzEntity{
  String _key;
  String _value;

  String get key => _key;

  set key(String value) {
    _key = value;
  }

  String get value => _value;

  set value(String value) {
    _value = value;
  }

  @override
  String toString() {
    return 'PcsFwzEntity{_key: $_key, _value: $_value}';
  }
}