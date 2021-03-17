part of 'people_online_check_bloc.dart';

@immutable
abstract class PeopleOnlineCheckEvent {
  PeopleOnlineCheckEvent();
}

// ignore: must_be_immutable
class NationSureEvent extends PeopleOnlineCheckEvent{
  String nationSure;
  NationSureEvent({@required this.nationSure});
}