import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'team_choose_event.dart';
part 'team_choose_state.dart';

class TeamChooseBloc extends Bloc<TeamChooseEvent, TeamChooseState> {
  TeamChooseBloc() : super(TeamChooseInitial());

  @override
  Stream<TeamChooseState> mapEventToState(
    TeamChooseEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
