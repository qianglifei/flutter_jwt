part of 'people_online_check_bloc.dart';

class PeopleOnlineCheckState {
  Map<String,dynamic> map;
  PeopleOnlineCheckState({this.map});

  ///初始化方法，基础变量也需要赋值，不然会报空指针异常
  PeopleOnlineCheckState init(){
    return PeopleOnlineCheckState()..map = new Map.from({});
  }
  ///clone 方法，此方法参考fish_redux 的clone 方法
  PeopleOnlineCheckState clone(){
    return PeopleOnlineCheckState()..map = map;
  }
}

class PeopleCheckSuccess{

    PeopleCheckSuccess();
}

class PeopleCheckError{
    PeopleCheckError();
}