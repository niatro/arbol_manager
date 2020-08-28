import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class FormEntity extends Equatable {
  final List<Cliente> clienteArbol;
  final List<Zona> zonaArbol;
  final List<Calle> calleArbol;
  final List<CalleEsquina> esquinaCalleArbol;
  final List<Especie> especieArbol;
  final List<EstadoGeneral> estadoGeneralArbol;
  final List<EstadoSanitario> estadoSanitarioArbol;
  final List<InclinacionTronco> inclinacionTroncoArbol;
  final List<OrientacionInclinacion> orientacionInclinacionArbol;
  final List<AccionObs> accionObsArbol;

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

class Cliente extends Equatable {
  final int clienteId;
  final String clienteNombre;
  Cliente({@required this.clienteId, @required this.clienteNombre});
  Map<String, dynamic> toMap() {
    return {
      'clienteId': clienteId,
      'clienteNombre': clienteNombre,
    };
  }
}

class Zona extends Equatable {
  final int zonaId;
  final String zonaNombre;
  Zona({@required this.zonaId, @required this.zonaNombre});
  Map<String, dynamic> toMap() {
    return {
      'zonaId': zonaId,
      'zonaNombre': zonaNombre,
    };
  }
}

class Calle extends Equatable {
  final int calleId;
  final int calleZonaId;
  final String calleNombre;
  Calle({
    @required this.calleId,
    @required this.calleZonaId,
    @required this.calleNombre,
  });
}

class CalleEsquina extends Equatable {
  final int calleEsquinaId;
  final int calleEsquinaZonaId;
  final String calleEsquinaNombre;
  CalleEsquina({
    @required this.calleEsquinaId,
    @required this.calleEsquinaZonaId,
    @required this.calleEsquinaNombre,
  });
}

class Especie extends Equatable {
  final int especieId;
  final String especieNombreComun;
  final String especieNombreCientifico;
  final int orden;
  final String icono;
  final String hojaGenerica;
  final String fotoGenerica;
  final String descripcion;

  Especie({
    @required this.especieId,
    @required this.especieNombreComun,
    @required this.especieNombreCientifico,
    @required this.orden,
    @required this.icono,
    @required this.hojaGenerica,
    @required this.fotoGenerica,
    @required this.descripcion,
  });
}

class EstadoGeneral extends Equatable {
  final int estadoGeneralId;
  final String estadoGeneralIdDesc;
  EstadoGeneral(
      {@required this.estadoGeneralId, @required this.estadoGeneralIdDesc});
}

class EstadoSanitario extends Equatable {
  final int estadoSanitarioId;
  final String estadoSanitarioDesc;
  EstadoSanitario({
    @required this.estadoSanitarioId,
    @required this.estadoSanitarioDesc,
  });
}

class InclinacionTronco extends Equatable {
  final int inclinacionTroncoId;
  final String inclinacionTroncoDesc;
  InclinacionTronco(
      {@required this.inclinacionTroncoId,
      @required this.inclinacionTroncoDesc});
}

class OrientacionInclinacion extends Equatable {
  final int orientacionInclinacionId;
  final String orientacionInclinacionDesc;
  OrientacionInclinacion(
      {@required this.orientacionInclinacionId,
      @required this.orientacionInclinacionDesc});
}

class AccionObs extends Equatable {
  final int accionObsId;
  final String accionObsDesc;
  final int accionObsOrden;

  AccionObs({
    @required this.accionObsId,
    @required this.accionObsDesc,
    @required this.accionObsOrden,
  });
}
