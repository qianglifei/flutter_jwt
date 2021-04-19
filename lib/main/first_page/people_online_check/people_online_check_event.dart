part of 'people_online_check_bloc.dart';

@immutable
abstract class PeopleOnlineCheckEvent {
  PeopleOnlineCheckEvent();
}

///初始化事件,这里不需要传什么值，过来
class PeopleOnlineCheckInitEvent extends PeopleOnlineCheckEvent{}

/// 线上校验事件
// ignore: must_be_immutable
class PeopleCheckEvent extends PeopleOnlineCheckEvent{
  Map<String,dynamic> map = new Map.from({});
  PeopleCheckEvent({@required this.map});
}