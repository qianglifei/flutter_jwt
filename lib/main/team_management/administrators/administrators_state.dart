part of 'administrators_bloc.dart';

@immutable
abstract class AdministratorsState {}

class AdministratorsInitial extends AdministratorsState {}

/// 管理员请求成功状态
class AdministratorsSuccessState extends AdministratorsState{
  AdministratorsResponseEntity dataModel;
  AdministratorsSuccessState(this.dataModel);
}

/// 管理员请求失败状态
class AdministratorsFailureState extends AdministratorsState{
  String errMsg;
  AdministratorsFailureState(this.errMsg);
}
