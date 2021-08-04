part of 'administrators_bloc.dart';

@immutable
abstract class AdministratorsEvent {

}

class AdministratorsRequestEvent extends AdministratorsEvent{
   Map<String,dynamic> requestBody = Map.from({});
   AdministratorsRequestEvent({@required requestBody});
}
