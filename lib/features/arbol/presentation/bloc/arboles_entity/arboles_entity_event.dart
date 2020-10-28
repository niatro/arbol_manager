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

class UpdateArbolEvent extends ArbolesEntityEvent {
  final ArbolesEntity arboles;
  final int nArbol;

  UpdateArbolEvent(this.arboles, this.nArbol) : super([arboles, nArbol]);
}
