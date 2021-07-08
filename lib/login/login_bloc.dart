import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jwt/config/url_config.dart';
import 'package:jwt/entity/login_response_entity.dart';
import 'package:jwt/http/dio_utils.dart';
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
      if(event is LoginPressEvent){
        LoginResponseEntity entity = await LoginRepository.loginRequest(event.map);
        print(entity.userName);
        print("请求完毕，返回数据");
        yield LoginSuccessState(entity);
        // if(entity. == "1"){
        //
        // }else{
        //   yield LoginFailureState("");
        // }
      }
  }
}

