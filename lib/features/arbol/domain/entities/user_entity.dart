import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String idUsuario;
  final String nombreUsuario;
  final String apellidoUsuario;
  final String rutUsuario;
  final String cliente;
  final String detallePerfilUser;
  final String activoUsuario;
  final LatLng localizacion;
  final DateTime fechaHora;

  UserEntity(
      {@required this.idUsuario,
      @required this.nombreUsuario,
      @required this.apellidoUsuario,
      @required this.rutUsuario,
      @required this.cliente,
      @required this.detallePerfilUser,
      @required this.activoUsuario,
      this.localizacion,
      this.fechaHora});
}
