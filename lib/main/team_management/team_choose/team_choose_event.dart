part of 'team_choose_bloc.dart';

///用来判断bloc返回哪个state
abstract class TeamChooseEvent {
  TeamChooseEvent();
}

///初始化事件，这里不需要传什么值过来
class TeamChooseInitEvent extends TeamChooseEvent{

}

///请求民警事件
class PoliceEvent extends TeamChooseEvent{
   Map<String,dynamic> map = new Map.from({});
   PoliceEvent({@required this.map});
}

class StatisticsEvent extends TeamChooseEvent{
  Map<String,dynamic> map = new Map.from({});
  StatisticsEvent({@required this.map});
}
