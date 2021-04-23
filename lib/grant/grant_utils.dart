
import 'package:permission_handler/permission_handler.dart';

class GrantedUtils {
  //工厂模式,提供一个工厂方法来获取该实例类
  factory GrantedUtils() => _getInstance();

  static GrantedUtils get instance => _getInstance();

  static GrantedUtils _instance;

  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses;

  GrantedUtils.internal() {
    // 初始化
    initPermissionData();
  }

  static GrantedUtils _getInstance(){
    if(_instance == null){
      _instance = new GrantedUtils.internal();
    }
    return _instance;
  }

  Future initPermissionData() async{
    statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
    ].request();

    statuses.forEach((key, value) {
          print(key);
          print(value);
    });
  }

  // 检查是否有权限
  void requestPermissionGranted() async{

  }
}