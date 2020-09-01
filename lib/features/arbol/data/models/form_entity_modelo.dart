import 'package:equatable/equatable.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:meta/meta.dart';

class FormEntityModelo extends FormEntity {
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

  FormEntityModelo({
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
  });

  factory FormEntityModelo.fromJson(Map<String, dynamic> json) {
    return FormEntityModelo(
      clienteArbol: json["clienteArbol"],
      zonaArbol: json["zonaArbol"],
      calleArbol: json["calleArbol"],
      esquinaCalleArbol: json["esquinaCalleArbol"],
      especieArbol: json["especieArbol"],
      estadoGeneralArbol: json["estadoGeneralArbol"],
      estadoSanitarioArbol: json["estadoSanitarioArbol"],
      inclinacionTroncoArbol: json["inclinacionTroncoArbol"],
      orientacionInclinacionArbol: json["orientacionInclinacionArbol"],
      accionObsArbol: json["accionObsArbol"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['clienteArbol'] = this.clienteArbol;
    data['zonaArbol'] = this.zonaArbol;
    data['calleArbol'] = this.calleArbol;
    data['esquinaCalleArbol'] = this.esquinaCalleArbol;
    data['especieArbol'] = this.especieArbol;
    data['estadoGeneralArbol'] = this.estadoGeneralArbol;
    data['estadoSanitarioArbol'] = this.estadoSanitarioArbol;
    data['inclinacionTroncoArbol'] = this.inclinacionTroncoArbol;
    data['orientacionInclinacionArbol'] = this.orientacionInclinacionArbol;
    data['accionObsArbol'] = this.accionObsArbol;
    return data;
  }

  FormEntity toEntity() {
    return FormEntity(
      clienteArbol: this.clienteArbol,
      zonaArbol: this.zonaArbol,
      calleArbol: this.calleArbol,
      esquinaCalleArbol: this.esquinaCalleArbol,
      especieArbol: this.especieArbol,
      estadoGeneralArbol: this.estadoGeneralArbol,
      estadoSanitarioArbol: this.estadoSanitarioArbol,
      inclinacionTroncoArbol: this.inclinacionTroncoArbol,
      orientacionInclinacionArbol: this.orientacionInclinacionArbol,
      accionObsArbol: this.accionObsArbol,
    );
  }
}

abstract class ObjetoTabla {
  Map<String, dynamic> toMap();
  ObjetoTabla.fromMapToObject(Map<String, dynamic> map);
}

class ClienteModelo extends ClienteEntity implements ObjetoTabla {
  int _clienteId;
  String _clienteNombre;
  ClienteModelo(this._clienteNombre);
  ClienteModelo.conId(this._clienteId, this._clienteNombre)
      : super(
          clienteId: _clienteId,
          clienteNombre: _clienteNombre,
        );
  int get clienteId => _clienteId;
  String get clienteNombre => _clienteNombre;

  set clienteNombre(String cliente) {
    if (cliente.length <= 255) {
      this._clienteNombre = cliente;
    }
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (clienteId != null) {
      map['clienteId'] = _clienteId;
    }
    map['clienteNombre'] = _clienteNombre;
    return map;
  }

  @override
  ClienteModelo.fromMapToObject(Map<String, dynamic> map) {
    this._clienteId = map['clienteId'];
    this._clienteNombre = map['clienteNombre'];
  }
}

class ZonaModelo extends ZonaEntity implements ObjetoTabla {
  int _clienteId;
  int _zonaId;
  String _zonaNombre;
  ZonaModelo({clienteId, zonaNombre})
      : this._clienteId = clienteId,
        this._zonaNombre = zonaNombre;
  ZonaModelo.conId(this._zonaId, this._clienteId, this._zonaNombre)
      : super(
          zonaId: _zonaId,
          zonaNombre: _zonaNombre,
        );
  @required
  int get clienteId => _clienteId;
  @required
  int get zonaId => _zonaId;
  @required
  String get zonaNombre => _zonaNombre;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (zonaId != null) {
      map['zonaId'] = _zonaId;
    }
    map['clienteId'] = _clienteId;
    map['zonaNombre'] = _zonaNombre;
    return map;
  }

  ZonaModelo.fromMapToObject(Map<String, dynamic> map) {
    this._clienteId = map['clienteId'];
    this._zonaId = map['zonaId'];
    this._zonaNombre = map['zonaNombre'];
  }
}

class CalleModelo extends CalleEntity {
  CalleModelo({
    @required int calleId,
    @required int calleZonaId,
    @required String calleNombre,
  });
}

class CalleEsquinaModelo extends CalleEsquinaEntity {
  CalleEsquinaModelo({
    @required int calleEsquinaId,
    @required int calleEsquinaZonaId,
    @required String calleEsquinaNombre,
  });
}

class EspecieModelo extends EspecieEntity {
  EspecieModelo({
    @required int especieId,
    @required String especieNombreComun,
    @required String especieNombreCientifico,
    @required int orden,
    @required String icono,
    @required String hojaGenerica,
    @required String fotoGenerica,
    @required String descripcion,
  });
}

class EstadoGeneralModelo extends EstadoGeneralEntity {
  EstadoGeneralModelo({
    @required int estadoGeneralId,
    @required String estadoGeneralIdDesc,
  });
}

class EstadoSanitarioModelo extends EstadoSanitarioEntity {
  EstadoSanitarioModelo({
    @required int estadoSanitarioId,
    @required String estadoSanitarioDesc,
  });
}

class InclinacionTroncoModelo extends InclinacionTroncoEntity {
  InclinacionTroncoModelo({
    @required int inclinacionTroncoId,
    @required String inclinacionTroncoDesc,
  });
}

class OrientacionInclinacionModelo extends OrientacionInclinacionEntity {
  OrientacionInclinacionModelo({
    @required int orientacionInclinacionId,
    @required String orientacionInclinacionDesc,
  });
}

class AccionObsModelo extends AccionObsEntity {
  AccionObsModelo({
    @required int accionObsId,
    @required String accionObsDesc,
    @required int accionObsOrden,
  });
}
