part of 'login_bloc.dart';

/// 用来判断bloc返回哪一个state
@immutable
abstract class LoginEvent {
  LoginEvent();
}
///初始化事件,这里不需要传什么值，过来
class LoginInitEvent extends LoginEvent{

}

///登录点击事件
// ignore: must_be_immutable
class LoginPressEvent extends LoginEvent{
  Map<String,dynamic> map = new Map.from({});
  LoginPressEvent({@required this.map});
}