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

abstract class ObjetoFila {
  int idFila;
  Map<String, dynamic> toMap();
  ObjetoFila.fromMapToObject(Map<String, dynamic> map);
}

//TODO: falta el modelo para agente patogeno 😱
//TODO: falta el modelo para lugar de plaga patogeno 😱
//TODO: falta el modelo para  para  plaga 😱

//OJO: Cliente
class ClienteModelo extends ClienteEntity implements ObjetoFila {
  int _clienteId;
  String _clienteNombre;
  ClienteModelo({clienteNombre}) : this._clienteNombre = clienteNombre;
  ClienteModelo.conId(this._clienteId, this._clienteNombre)
      : super(
          clienteId: _clienteId,
          clienteNombre: _clienteNombre,
        );
  int get clienteId => _clienteId;
  String get clienteNombre => _clienteNombre;

  @override
  int get idFila => _clienteId;
  @override
  set idFila(int clienteId) {
    this.idFila = clienteId;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
//    if (clienteId != null) {
//      map['clienteId'] = _clienteId;
//    }
    map['clienteNombre'] = _clienteNombre;
    return map;
  }

  @override
  ClienteModelo.fromMapToObject(Map<String, dynamic> map) {
    this._clienteId = map['clienteId'];
    this._clienteNombre = map['clienteNombre'];
  }

  factory ClienteModelo.fromJson(Map<String, dynamic> json) {
    return ClienteModelo(clienteNombre: json["detalle_entidad"]);
  }
}

class ListaClienteModelo {
  final List<ClienteModelo> listaClientes;
  ListaClienteModelo({
    @required this.listaClientes,
  });
  factory ListaClienteModelo.fromJson(List<dynamic> parsedJson) {
    List<ClienteModelo> _listaClientes = List<ClienteModelo>();
    _listaClientes = parsedJson.map((i) => ClienteModelo.fromJson(i)).toList();
    return ListaClienteModelo(listaClientes: _listaClientes);
  }
}

//OJO: Zona
class ZonaModelo extends ZonaEntity implements ObjetoFila {
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
          clienteId: _clienteId,
        );
  @required
  int get clienteId => _clienteId;
  @required
  int get zonaId => _zonaId;
  @required
  String get zonaNombre => _zonaNombre;

  @override
  int get idFila => _zonaId;
  @override
  set idFila(int zonaId) {
    this._zonaId = zonaId;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (zonaId != null) {
      map['zonaId'] = _zonaId;
    }
    map['zonaNombre'] = _zonaNombre;
    map['clienteId'] = _clienteId;
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

//OJO: Especie
class EspecieModelo extends EspecieEntity implements ObjetoFila {
  int _especieOrigenId;
  String _especieNombreComun;
  String _especieNombreCientifico;
  int _especieOrden;
  String _especieIcono;
  String _especieHojaGenerica;
  String _especieFotoGenerica;
  String _especieDescripcion;
  EspecieModelo({
    @required int especieOrigenId,
    @required String especieNombreComun,
    @required String especieNombreCientifico,
    @required int especieOrden,
    @required String especieIcono,
    @required String especieHojaGenerica,
    @required String especieFotoGenerica,
    @required String especieDescripcion,
  })  : this._especieOrigenId = especieOrigenId,
        this._especieNombreComun = especieNombreComun,
        this._especieNombreCientifico = especieNombreCientifico,
        this._especieOrden = especieOrden,
        this._especieIcono = especieIcono,
        this._especieHojaGenerica = especieHojaGenerica,
        this._especieFotoGenerica = especieFotoGenerica,
        this._especieDescripcion = especieDescripcion;

  int get especieOrigenId => _especieOrigenId;
  String get especieNombreComun => _especieNombreComun;
  String get especieNombreCientifico => _especieNombreCientifico;
  int get especieOrden => _especieOrden;
  String get especieIcono => _especieIcono;
  String get especieHojaGenerica => _especieHojaGenerica;
  String get especieFotoGenerica => _especieFotoGenerica;
  String get especieDescripcion => _especieDescripcion;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['especieOrigenId'] = _especieOrigenId;
    map['especieNombreComun'] = _especieNombreComun;
    map['especieNombreCientifico'] = _especieNombreCientifico;
    map['especieOrden'] = _especieOrden;
    map['especieIcono'] = _especieIcono;
    map['especieHojaGenerica'] = _especieHojaGenerica;
    map['especieFotoGenerica'] = _especieFotoGenerica;
    map['especieDescripcion'] = especieDescripcion;
    return map;
  }

  @override
  EspecieModelo.fromMapToObject(Map<String, dynamic> map) {
    this._especieOrigenId = map['especieOrigenId'];
    this._especieNombreComun = map['especieNombreComun'];
    this._especieNombreCientifico = map['especieNombreCientifico'];
    this._especieOrden = map['especieOrden'];
    this._especieIcono = map['especieIcono'];
    this._especieHojaGenerica = map['especieHojaGenerica'];
    this._especieFotoGenerica = map['especieFotoGenerica'];
    this._especieDescripcion = map['especieDescripcion'];
  }

  factory EspecieModelo.fromJson(Map<String, dynamic> json) {
    return EspecieModelo(
      especieOrigenId: json['id_especie'],
      especieNombreComun: json['detalle_especie'],
      especieNombreCientifico: json['detalle_cientifico_especie'],
      especieOrden: json['orden_especie'],
      especieIcono: json['especie_icono'],
      especieHojaGenerica: json['especie_hoja'] ?? 'Falta link a la imagen',
      especieFotoGenerica: json['especie_foto'] ?? 'Falta link a la imagen',
      especieDescripcion: json['especie_descr'] ?? 'Falta la descripcion',
    );
  }
}

class ListaEspecieModelo {
  final List<EspecieModelo> listaEspecie;
  ListaEspecieModelo({
    @required this.listaEspecie,
  });
  factory ListaEspecieModelo.fromJson(List<dynamic> parsedJson) {
    List<EspecieModelo> _listaEspecie = List<EspecieModelo>();
    _listaEspecie = parsedJson.map((i) => EspecieModelo.fromJson(i)).toList();
    return ListaEspecieModelo(listaEspecie: _listaEspecie);
  }
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

class UsuarioModelo extends AccionObsEntity {
  UsuarioModelo({
    @required int usuarioId,
    @required String usuarioGUI,
    @required String usuarioCliente,
    @required String usuarioRol,
    @required String usarioNombre,
    @required String usuarioApellido,
    @required String usuarioEmail,
    @required DateTime usuarioCreacion,
    @required String usuarioActividad,
  });
}
