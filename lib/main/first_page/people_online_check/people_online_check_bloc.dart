import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/http/dio_utils.dart';
import 'package:jwt/main/first_page/people_online_check/people_online_check_response_entity.dart';
import 'package:meta/meta.dart';

part 'people_online_check_event.dart';
part 'people_online_check_state.dart';

class PeopleOnlineCheckBloc extends Bloc<PeopleOnlineCheckEvent, PeopleOnlineCheckState> {
  PeopleOnlineCheckBloc() : super(PeopleOnlineCheckState().init());

  @override
  Stream<PeopleOnlineCheckState> mapEventToState(PeopleOnlineCheckEvent event) async* {
    // TODO: implement mapEventToState
    // TODO: View 中 添加的事件，会在此处调用，此处处理数据后，将数据yield,只能触发一次BlockBuilder，
    // TODO：它内部就会比较上一次的MainState对象，如果相同，就不build了
//    if(event is PeopleOnlineCheckInitEvent){
//       yield await init();
//    }else if(event is PeopleCheckEvent){
//      yield peopleCheckData();
//    }

  }



}
