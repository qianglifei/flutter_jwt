
import 'package:flutter/cupertino.dart';

class DataBean{
  String _title;
  String _content;
  Color _contentColor;

  DataBean(this._title, this._content, this._contentColor);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get content => _content;

  Color get contentColor => _contentColor;

  set contentColor(Color value) {
    _contentColor = value;
  }

  set content(String value) {
    _content = value;
  }
}