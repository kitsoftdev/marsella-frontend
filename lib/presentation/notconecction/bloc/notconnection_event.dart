import 'package:equatable/equatable.dart';

///Interfaz de todos los eventos del NotConnection
abstract class NotConnectionEvent extends Equatable {
  const NotConnectionEvent();
  @override
  List<Object> get props => [];
}



class OnNotConnectionInternet extends NotConnectionEvent {
  const OnNotConnectionInternet();

  @override
  List<Object> get props => [];
}

class OnNotConnectionStarter extends NotConnectionEvent {}
