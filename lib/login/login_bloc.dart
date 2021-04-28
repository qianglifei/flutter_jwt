import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/login/login_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';
///bloc 组合事件和state
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitState().init());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    try{
      if(event is LoginPressEvent){
         LoginResponseEntity responseEntity = await LoginRepository.loginRequest(event.map);
         print(responseEntity.toString());
         yield LoginSuccessState(responseEntity);
      }
    }catch(e){
      final errMsg = '登录错误';
      yield LoginFailureState(errMsg);
    }
  }
}

