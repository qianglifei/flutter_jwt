part of 'login_bloc.dart';

abstract class LoginState{
  const LoginState();
}

class LoginInitState {
//  Map<String,dynamic> map;
//  LoginState({this.map});
//
//  ///初始化方法，基础变量也需要赋值，不然会报空指针异常
  LoginState init(){

  }
//  ///clone 方法，此方法参考fish_redux 的clone 方法
//  LoginState clone(){
//    return LoginState()..map = map;
//  }
}

/// 登录成功状态
class LoginSuccessState extends LoginState{
    LoginResponseEntity loginModel;
    LoginSuccessState(this.loginModel);
}

/// 登录失败状态
class LoginFailureState extends LoginState{
    String errMsg;
    LoginFailureState(this.errMsg);
}