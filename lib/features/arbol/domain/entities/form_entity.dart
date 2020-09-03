import 'package:equatable/equatable.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class FormEntity extends Equatable {
  final List<ClienteEntity> clienteArbol;
  final List<ZonaEntity> zonaArbol;
  final List<CalleEntity> calleArbol;
  final List<CalleEsquinaEntity> esquinaCalleArbol;
  final List<EspecieEntity> especieArbol;
  final List<EstadoGeneralEntity> estadoGeneralArbol;
  final List<EstadoSanitarioEntity> estadoSanitarioArbol;
  final List<InclinacionTroncoEntity> inclinacionTroncoArbol;
  final List<OrientacionInclinacionEntity> orientacionInclinacionArbol;
  final List<AccionObsEntity> accionObsArbol;

  FormEntity({
    @required this.clienteArbol,
    @required this.zonaArbol,
    @required this.calleArbol,
    @required this.esquinaCalleArbol,
    @required this.especieArbol,
    @required this.estadoGeneralArbol,
    @required this.estadoSanitarioArbol,
    @required this.inclinacionTroncoArbol,
    @required this.orientacionInclinacionArbol,
    @required this.accionObsArbol,
  }) : super([
          clienteArbol,
          zonaArbol,
          calleArbol,
          esquinaCalleArbol,
          especieArbol,
          estadoGeneralArbol,
          estadoSanitarioArbol,
          inclinacionTroncoArbol,
          orientacionInclinacionArbol,
          accionObsArbol,
        ]);
}

class ClienteEntity {
  int clienteId;
  String clienteNombre;
  ClienteEntity({
    @required this.clienteId,
    @required this.clienteNombre,
  });
}

class ZonaEntity {
  final int zonaId;
  final String zonaNombre;
  final int clienteId;
  ZonaEntity({
    @required this.zonaId,
    @required this.zonaNombre,
    @required this.clienteId,
  });
}

class CalleEntity {
  final int calleId;
  final int calleZonaId;
  final String calleNombre;
  CalleEntity({
    @required this.calleId,
    @required this.calleZonaId,
    @required this.calleNombre,
  });
}

class CalleEsquinaEntity {
  final int calleEsquinaId;
  final int calleEsquinaZonaId;
  final String calleEsquinaNombre;
  CalleEsquinaEntity({
    @required this.calleEsquinaId,
    @required this.calleEsquinaZonaId,
    @required this.calleEsquinaNombre,
  });
}

class EspecieEntity {
  final int especieIdOrigen;
  final String especieNombreComun;
  final String especieNombreCientifico;
  final int especieOrden;
  final String especieIcono;
  final String especieHojaGenerica;
  final String especieFotoGenerica;
  final String especieDescripcion;

  EspecieEntity({
    @required this.especieIdOrigen,
    @required this.especieNombreComun,
    @required this.especieNombreCientifico,
    @required this.especieOrden,
    @required this.especieIcono,
    @required this.especieHojaGenerica,
    @required this.especieFotoGenerica,
    @required this.especieDescripcion,
  });
}

class EstadoGeneralEntity {
  final int estadoGeneralId;
  final String estadoGeneralIdDesc;
  EstadoGeneralEntity(
      {@required this.estadoGeneralId, @required this.estadoGeneralIdDesc});
}

class EstadoSanitarioEntity {
  final int estadoSanitarioId;
  final String estadoSanitarioDesc;
  EstadoSanitarioEntity({
    @required this.estadoSanitarioId,
    @required this.estadoSanitarioDesc,
  });
}

class InclinacionTroncoEntity {
  final int inclinacionTroncoId;
  final String inclinacionTroncoDesc;
  InclinacionTroncoEntity(
      {@required this.inclinacionTroncoId,
      @required this.inclinacionTroncoDesc});
}

class OrientacionInclinacionEntity {
  final int orientacionInclinacionId;
  final String orientacionInclinacionDesc;
  OrientacionInclinacionEntity(
      {@required this.orientacionInclinacionId,
      @required this.orientacionInclinacionDesc});
}

class AccionObsEntity {
  final int accionObsId;
  final String accionObsDesc;
  final int accionObsOrden;

  AccionObsEntity({
    @required this.accionObsId,
    @required this.accionObsDesc,
    @required this.accionObsOrden,
  });
}

class UsuarioEntity {
  final int usuarioId;
  final String usuarioGUI;
  final String usuarioCliente;
  final String usuarioRol;
  final String usarioNombre;
  final String usuarioApellido;
  final String usuarioEmail;
  final DateTime usuarioCreacion;
  final String usuarioActividad;

  UsuarioEntity({
    @required this.usuarioId,
    @required this.usuarioGUI,
    @required this.usuarioCliente,
    @required this.usuarioRol,
    @required this.usarioNombre,
    @required this.usuarioApellido,
    @required this.usuarioEmail,
    @required this.usuarioCreacion,
    @required this.usuarioActividad,
  });
}
