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
  final List<UsuarioEntity> usuarios;
  final List<AgentePatogenoEntity> agentesPatogenos;
  final List<LugarPlagaEntity> lugaresPlaga;
  final List<PlagaEntity> plagas;
  final List<SintomaEntity> sintomas;

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
    @required this.usuarios,
    @required this.agentesPatogenos,
    @required this.lugaresPlaga,
    @required this.plagas,
    @required this.sintomas,
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
          usuarios,
          agentesPatogenos,
          lugaresPlaga,
          plagas,
          sintomas,
        ]);
}

class ClienteEntity {
  int clienteOrigenId;
  String clienteNombre;
  ClienteEntity({
    @required this.clienteOrigenId,
    @required this.clienteNombre,
  });
}

class ZonaEntity {
  final int zonaOrigenId;
  final String zonaNombre;
  final int clienteId;
  ZonaEntity({
    @required this.zonaOrigenId,
    @required this.zonaNombre,
    @required this.clienteId,
  });
}

class CalleEntity {
  final int calleOrigenId;
  final int calleZonaId;
  final String calleNombre;
  final String calleTipo;
  CalleEntity({
    @required this.calleOrigenId,
    @required this.calleZonaId,
    @required this.calleNombre,
    @required this.calleTipo,
  });
}

class CalleEsquinaEntity {
  final int calleEsquinaOrigenId;
  final int calleEsquinaZonaId;
  final String calleEsquinaNombre;
  final String calleEsquinaTipo;
  CalleEsquinaEntity({
    @required this.calleEsquinaTipo,
    @required this.calleEsquinaOrigenId,
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
  final int estadoGeneralOrigenId;
  final String estadoGeneralDesc;
  EstadoGeneralEntity({
    @required this.estadoGeneralOrigenId,
    @required this.estadoGeneralDesc,
  });
}

class EstadoSanitarioEntity {
  final int estadoSanitarioOrigenId;
  final String estadoSanitarioDesc;
  EstadoSanitarioEntity({
    @required this.estadoSanitarioOrigenId,
    @required this.estadoSanitarioDesc,
  });
}

class InclinacionTroncoEntity {
  final int inclinacionTroncoOrigenId;
  final String inclinacionTroncoDesc;
  InclinacionTroncoEntity(
      {@required this.inclinacionTroncoOrigenId,
      @required this.inclinacionTroncoDesc});
}

class OrientacionInclinacionEntity {
  final int orientacionInclinacionOrigenId;
  final String orientacionInclinacionDesc;
  OrientacionInclinacionEntity(
      {@required this.orientacionInclinacionOrigenId,
      @required this.orientacionInclinacionDesc});
}

class AccionObsEntity {
  final int accionObsOrigenId;
  final String accionObsDesc;
  final int accionObsOrden;

  AccionObsEntity({
    @required this.accionObsOrigenId,
    @required this.accionObsDesc,
    @required this.accionObsOrden,
  });
}

class UsuarioEntity {
  final int usuarioOrigenId;
  final String usuarioGUI;
  final int usuarioCliente;
  final int usuarioRol;
  final String usuarioNombre;
  final String usuarioApellido;
  final String usuarioEmail;
  final String usuarioCreacion;
  final String usuarioActividad;

  UsuarioEntity({
    @required this.usuarioOrigenId,
    @required this.usuarioGUI,
    @required this.usuarioCliente,
    @required this.usuarioRol,
    @required this.usuarioNombre,
    @required this.usuarioApellido,
    @required this.usuarioEmail,
    @required this.usuarioCreacion,
    @required this.usuarioActividad,
  });
}

class AgentePatogenoEntity {
  final int agentePatogenoOrigenId;
  final String agentePatogenoDesc;

  AgentePatogenoEntity({
    @required this.agentePatogenoOrigenId,
    @required this.agentePatogenoDesc,
  });
}

class LugarPlagaEntity {
  final int lugarPlagaOrigenId;
  final String lugarPlagaDesc;

  LugarPlagaEntity({
    @required this.lugarPlagaOrigenId,
    @required this.lugarPlagaDesc,
  });
}

class PlagaEntity {
  final int plagaOrigenId;
  final String plagaDesc;
  final int plagaId;

  PlagaEntity({
    @required this.plagaOrigenId,
    @required this.plagaDesc,
    @required this.plagaId,
  });
}

class SintomaEntity {
  final int sintomaOrigenId;
  final String sintomaDesc;
  final int sintomaId;

  SintomaEntity({
    @required this.sintomaOrigenId,
    @required this.sintomaDesc,
    @required this.sintomaId,
  });
}
