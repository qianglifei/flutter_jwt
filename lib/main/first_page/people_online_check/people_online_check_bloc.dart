import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'people_online_check_event.dart';
part 'people_online_check_state.dart';

class PeopleOnlineCheckBloc extends Bloc<PeopleOnlineCheckEvent, PeopleOnlineCheckState> {
  PeopleOnlineCheckBloc() : super(PeopleOnlineCheckState().init());

  @override
  Stream<PeopleOnlineCheckState> mapEventToState(PeopleOnlineCheckEvent event) async* {
    // TODO: implement mapEventToState
    if(event is PeopleOnlineCheckInitEvent){
       yield
    }
  }
}
