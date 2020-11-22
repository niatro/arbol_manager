import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

class UserEntityModel extends UserEntity {
  UserEntityModel(
      {@required String idUsuario,
      @required String nombreUsuario,
      @required String rutUsuario,
      @required String apellidoUsuario,
      @required String activoUsuario,
      @required String detallePerfilUser,
      @required String cliente})
      : super(
          idUsuario: idUsuario,
          nombreUsuario: nombreUsuario,
          rutUsuario: rutUsuario,
          apellidoUsuario: apellidoUsuario,
          activoUsuario: activoUsuario,
          detallePerfilUser: detallePerfilUser,
          cliente: cliente,
        );

  factory UserEntityModel.fromJson(Map<String, dynamic> json) {
    return UserEntityModel(
      idUsuario: json['id_usuario'],
      nombreUsuario: json['nombre_usuario'],
      rutUsuario: json['rut_usuario'],
      apellidoUsuario: json['apellido_usuario'],
      activoUsuario: json['activo_usuario'],
      detallePerfilUser: json['detalle_perfil_user'],
      cliente: json['detalle_entidad'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_usuario'] = this.idUsuario;
    data['nombre_usuario'] = this.nombreUsuario;
    data['rut_usuario'] = this.rutUsuario;
    data['apellido_usuario'] = this.apellidoUsuario;
    data['activo_usuario'] = this.activoUsuario;
    data['detalle_perfil_user'] = this.detallePerfilUser;
    data['detalle_entidad'] = this.cliente;
    return data;
  }
}
