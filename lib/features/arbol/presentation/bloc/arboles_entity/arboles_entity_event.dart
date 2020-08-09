part of 'arboles_entity_bloc.dart';

@immutable
abstract class ArbolesEntityEvent extends Equatable {
  ArbolesEntityEvent([List props = const <dynamic>[]]) : super(props);
}

class GetArbolesEntityCercanosPorCoordenada extends ArbolesEntityEvent {
  final String coordenada;

  GetArbolesEntityCercanosPorCoordenada(this.coordenada) : super([coordenada]);
}

class GetArbolesEntityCercanosPorIdNFC extends ArbolesEntityEvent {
  final String idNFC;

  GetArbolesEntityCercanosPorIdNFC(this.idNFC) : super([idNFC]);
}
