part of 'arboles_entity_bloc.dart';

@immutable
abstract class ArbolesEntityEvent extends Equatable {
  ArbolesEntityEvent([List props = const <dynamic>[]]) : super(props);
}

class GetArbolesEntityCercanosEvent extends ArbolesEntityEvent {
  final String coordenada;

  GetArbolesEntityCercanosEvent(this.coordenada) : super([coordenada]);
}

class GetArbolesEntityPorIdNFCEvent extends ArbolesEntityEvent {
  final String idNFC;

  GetArbolesEntityPorIdNFCEvent(this.idNFC) : super([idNFC]);
}

class GrabarArbolEvent extends ArbolesEntityEvent {
  final ArbolesEntity arboles;
  final int nArbol;
  GrabarArbolEvent(this.arboles, this.nArbol) : super([arboles, nArbol]);
}

class ActualizarFormEvent extends ArbolesEntityEvent {
  final UserEntity usuario;
  ActualizarFormEvent(this.usuario) : super([usuario]);
}

class LoginUserEvent extends ArbolesEntityEvent {
  final String password;
  final String rut;
  LoginUserEvent(this.password, this.rut) : super([password, rut]);
}

class UpdateArbolEvent extends ArbolesEntityEvent {
  final ArbolesEntity arboles;
  final int nArbol;

  UpdateArbolEvent(this.arboles, this.nArbol) : super([arboles, nArbol]);
}

class GetDatosFormEvent extends ArbolesEntityEvent {
  final String idUsuario;
  GetDatosFormEvent(this.idUsuario) : super([idUsuario]);
}

class LeerIdNfcEvent extends ArbolesEntityEvent {
  final UserEntity usuario;
  LeerIdNfcEvent(this.usuario) : super([usuario]);
}

class GetCoordEvent extends ArbolesEntityEvent {}

class ComprobarIdNfcEvent extends ArbolesEntityEvent {
  final String idNfc;
  ComprobarIdNfcEvent(this.idNfc) : super([idNfc]);
}
