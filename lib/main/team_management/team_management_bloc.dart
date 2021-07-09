import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'team_management_event.dart';
part 'team_management_state.dart';

class TeamManagementBloc extends Bloc<TeamManagementEvent, TeamManagementState> {
  TeamManagementBloc() : super(TeamManagementInitial());

  @override
  Stream<TeamManagementState> mapEventToState(
    TeamManagementEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
