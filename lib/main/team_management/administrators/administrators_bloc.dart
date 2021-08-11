import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jwt/main/team_management/administrators/administrators_repository_entity.dart';
import 'package:meta/meta.dart';

import 'administrators_response_entity.dart';

part 'administrators_event.dart';
part 'administrators_state.dart';

class AdministratorsBloc extends Bloc<AdministratorsEvent, AdministratorsState> {
  AdministratorsBloc() : super(AdministratorsInitial());

  @override
  Stream<AdministratorsState> mapEventToState(AdministratorsEvent event) async* {
    // TODO: implement mapEventToState
    if(event is AdministratorsRequestEvent){
      AdministratorsResponseEntity responseEntity = await AdministratorsRepository.administratorsRequest(event.requestBody);
      yield AdministratorsSuccessState(responseEntity);
    }
  }
}
