import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String usuarioID;
  final String nombre;
  final String apellido;
  final String rut;
  final String cliente;
  final String perfil;
  final String estado;
  final LatLng localizacion;
  final DateTime fechaHora;

  UserEntity(
      {@required this.usuarioID,
      @required this.nombre,
      @required this.apellido,
      @required this.rut,
      @required this.cliente,
      @required this.perfil,
      @required this.estado,
      @required this.localizacion,
      @required this.fechaHora});
}
