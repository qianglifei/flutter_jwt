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
       DioUtils.instance.postHttp<LoginResponseEntity>(
            url: URLConfig.LOGIN ,
            method: DioUtils.POST,
            parameters:event.map,
            onSuccess: (data) {
              print("登录成功了：" + data.toJson().toString());
            //  yield LoginSuccessState(data);
            },
            onError: (error){
              return error;
            }
        );
      }
  }
}

