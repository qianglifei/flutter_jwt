
class GrantedUtils {
    //工厂模式
  factory GrantedUtils() => _getInstance();

  static GrantedUtils get instance => _getInstance();

  static GrantedUtils _instance;

  GrantedUtils.internal(){
    // 初始化
  }

  static GrantedUtils _getInstance(){
    if(_instance != null){
      _instance = new GrantedUtils.internal();
    }
    return _instance;
  }


}