part of 'administrators_bloc.dart';


abstract class AdministratorsEvent {
   AdministratorsEvent();
}

class AdministratorsRequestEvent extends AdministratorsEvent{
   Map<String,dynamic> requestBody = Map.from({});
   AdministratorsRequestEvent({@required this.requestBody});
}
