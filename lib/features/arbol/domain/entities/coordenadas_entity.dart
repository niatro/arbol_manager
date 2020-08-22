import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CoordenadasEntity extends Equatable {
  final String coordenadas;
  CoordenadasEntity({@required this.coordenadas}) : super([coordenadas]);
}
