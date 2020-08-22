import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String id;
  final String rol;
  final String entidad;
  UserEntity({@required this.id, @required this.rol, @required this.entidad})
      : super([id, rol, entidad]);
}
