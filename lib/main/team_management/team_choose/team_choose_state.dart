part of 'team_choose_bloc.dart';

abstract class TeamChooseState {

}

class TeamChooseInitial extends TeamChooseState {}

/// 民警请求成功状态
class PoliceSuccessState extends TeamChooseState{
  PoliceResponseEntity policeModel;
  PoliceSuccessState(this.policeModel);
}

/// 请求失败状态
class PoliceFailureState extends TeamChooseState{
  String errMsg;
  PoliceFailureState(this.errMsg);
}

class StatisticsSuccessState extends TeamChooseState{
  StatisticsResponseEntity statisticsModel;
  StatisticsSuccessState(this.statisticsModel);
}

// class StatisticsSuccessState extends TeamChooseState{
//   PoliceResponseEntity policeModel;
//   PoliceSuccessState(this.policeModel);
// }