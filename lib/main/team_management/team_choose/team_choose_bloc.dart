import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/main/team_management/team_choose/police_repository.dart';
import 'package:jwt/main/team_management/team_choose/police_response_entity.dart';
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
      print(entity.mjxx[0].mjxm);
      print("请求完毕，返回数据");
      yield PoliceSuccessState(entity);
    }
  }
}
