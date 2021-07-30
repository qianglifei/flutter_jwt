import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/main/team_management/team_choose/police_repository.dart';
import 'package:jwt/main/team_management/team_choose/police_response_entity.dart';
import 'package:jwt/main/team_management/team_choose/statistics_response_entity.dart';
import 'package:meta/meta.dart';

part 'team_choose_event.dart';
part 'team_choose_state.dart';

class TeamChooseBloc extends Bloc<TeamChooseEvent, TeamChooseState> {
  TeamChooseBloc() : super(TeamChooseInitial());

  @override
  Stream<TeamChooseState> mapEventToState(TeamChooseEvent event) async* {
    // TODO: implement mapEventToState
    if(event is PoliceEvent){
      PoliceResponseEntity entity = await PoliceRepository.policeRequest(event.map);
      print("请求完毕，返回数据");
      yield PoliceSuccessState(entity);
    }else if(event is PoliceEvent){
       StatisticsResponseEntity entity = await PoliceRepository.teamStatisticsRequest(event.map);
       yield StatisticsSuccessState(entity);
    }

  }
}
