import 'package:equatable/equatable.dart';

///Interfaz de roles para el Bloc
abstract class NotConnectionState extends Equatable {
  const NotConnectionState();

  @override
  List<Object> get props => [];
}

///Estado inicial de la página de roles.
class NotConnectionStart extends NotConnectionState {}

///Estado es para un proceso corriendo, así mostramos el spinner de carga
class NotConnectionLoading extends NotConnectionState {}

///Estado para cuando mostremos opciones de habilitar y deshabilitar
class NotConnectionEnabling extends NotConnectionState {}

class NotConnectionInternet extends NotConnectionState {}

///Estado para mostrar un problema en alguno de los procesos.
class NotConnectionError extends NotConnectionState {
  final String message;

  const NotConnectionError(this.message);

  @override
  List<Object> get props => [message];
}
