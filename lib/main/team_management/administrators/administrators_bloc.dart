import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'administrators_event.dart';
part 'administrators_state.dart';

class AdministratorsBloc extends Bloc<AdministratorsEvent, AdministratorsState> {
  AdministratorsBloc() : super(AdministratorsInitial());

  @override
  Stream<AdministratorsState> mapEventToState(
    AdministratorsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
