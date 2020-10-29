import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

UserEntity usuarioUno = UserEntity(
  usuarioID: '12345',
  nombre: 'Nicolas',
  apellido: 'Sanhueza',
  rut: '106473420',
  cliente: '1',
  perfil: '1',
  estado: 'activo',
  localizacion: LatLng(0, 0),
  fechaHora: DateTime(2020, 28, 10),
);
