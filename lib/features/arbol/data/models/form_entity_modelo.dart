import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:meta/meta.dart';

class FormEntityModelo extends FormEntity {
  final List<ClienteModelo> clientes;
  final List<ZonaModelo> zonas;
  final List<CalleModelo> calles;
  final List<CalleEsquinaModelo> esquinaCalles;
  final List<EspecieModelo> especies;
  final List<EstadoGeneralModelo> estadosGenerales;
  final List<EstadoSanitarioModelo> estadosSanitarios;
  final List<InclinacionTroncoModelo> inclinacionesTronco;
  final List<OrientacionInclinacionModelo> orientacionesInclinacion;
  final List<AccionObsModelo> accionesObs;
  final List<UsuarioModelo> usuarios;
  final List<AgentePatogenoModelo> agentesPatogenos;
  final List<LugarPlagaModelo> lugaresPlaga;
  final List<PlagaModelo> plagas;
  final List<SintomaModelo> sintomas;

  FormEntityModelo(
      {@required this.clientes,
      @required this.zonas,
      @required this.calles,
      @required this.esquinaCalles,
      @required this.especies,
      @required this.estadosGenerales,
      @required this.estadosSanitarios,
      @required this.inclinacionesTronco,
      @required this.orientacionesInclinacion,
      @required this.accionesObs,
      @required this.usuarios,
      @required this.agentesPatogenos,
      @required this.lugaresPlaga,
      @required this.plagas,
      @required this.sintomas});

/*  factory FormEntityModelo.fromJson(ObjetoLista json) {
    return FormEntityModelo(
      cliente: json["clienteArbol"],
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
  }*/

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['clienteArbol'] = this.clienteArbol;
    data['zonaArbol'] = this.zonaArbol;
    data['calleArbol'] = this.calleArbol;
    data['esquinaCalleArbol'] = this.esquinaCalleArbol;
    data['especieArbol'] = this.especieArbol;
    data['estadoGeneralArbol'] = this.estadoGeneralArbol;
    data['estadoSanitarioArbol'] = this.estadoSanitarioArbol;
    data['agentesPatogenos'] = this.agentesPatogenos;
    data['lugaresPlaga'] = this.lugaresPlaga;
    data['plagas'] = this.plagas;
    data['sintomas'] = this.sintomas;
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
      usuarios: this.usuarios,
      agentesPatogenos: this.agentesPatogenos,
      lugaresPlaga: this.lugaresPlaga,
      plagas: this.plagas,
      sintomas: this.sintomas,
    );
  }
}

class ObjetoLista {
  List<ObjetoFila> elementos;
  ObjetoLista({@required this.elementos});
}

abstract class ObjetoFila {
  int idFila;
  Map<String, dynamic> toMap();
  ObjetoFila.fromMapToObject(Map<String, dynamic> map);
}

//OJO: Cliente / revision v_1 ok
class ClienteModelo extends ClienteEntity implements ObjetoFila {
  int _clienteOrigenId;
  String _clienteNombre;
  ClienteModelo({
    @required clienteOrigenId,
    @required clienteNombre,
  })  : this._clienteOrigenId = clienteOrigenId,
        this._clienteNombre = clienteNombre;
  int get clienteOrigenId => _clienteOrigenId;
  String get clienteNombre => _clienteNombre;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['clienteOrigenId'] = _clienteOrigenId;
    map['clienteNombre'] = _clienteNombre;
    return map;
  }

  @override
  ClienteModelo.fromMapToObject(Map<String, dynamic> map) {
    this._clienteOrigenId = map['clienteOrigenId'];
    this._clienteNombre = map['clienteNombre'];
  }

  factory ClienteModelo.fromJson(Map<String, dynamic> json) {
    return ClienteModelo(
      clienteOrigenId: int.parse(json['id_entidad']),
      clienteNombre: json["detalle_entidad"],
    );
  }
}

class ListaClienteModelo extends ObjetoLista implements ObjetoFila {
  final List<ClienteModelo> listaClientes;
  ListaClienteModelo({
    @required this.listaClientes,
  }) : super(elementos: listaClientes);
  factory ListaClienteModelo.fromJson(List<dynamic> parsedJson) {
    List<ClienteModelo> _listaClientes = List<ClienteModelo>();
    _listaClientes = parsedJson.map((i) => ClienteModelo.fromJson(i)).toList();
    return ListaClienteModelo(listaClientes: _listaClientes);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Zona / Rev 1
class ZonaModelo extends ZonaEntity implements ObjetoFila {
  int _zonaOrigenId;
  int _clienteId;
  String _zonaNombre;
  ZonaModelo({
    zonaOrigenId,
    clienteId,
    zonaNombre,
  })  : this._zonaOrigenId = zonaOrigenId,
        this._clienteId = clienteId,
        this._zonaNombre = zonaNombre;
  int get zonaOrigenId => _zonaOrigenId;
  int get clienteId => _clienteId;
  String get zonaNombre => _zonaNombre;

  @override
  int idFila;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['zonaOrigenId'] = _zonaOrigenId;
    map['clienteId'] = _clienteId;
    map['zonaNombre'] = _zonaNombre;
    return map;
  }

  ZonaModelo.fromMapToObject(Map<String, dynamic> map) {
    this._zonaOrigenId = map['zonaOrigenId'];
    this._clienteId = map['clienteId'];
    this._zonaNombre = map['zonaNombre'];
  }
  factory ZonaModelo.fromJson(Map<String, dynamic> json) {
    return ZonaModelo(
      clienteId: int.parse(json['id_entidad_sector_entidad']),
      zonaOrigenId: int.parse(json['id_sector_entidad']),
      zonaNombre: json['detalle_sector_entidad'],
    );
  }
}

class ListaZonaModelo extends ObjetoLista implements ObjetoFila {
  final List<ZonaModelo> listaZona;

  ListaZonaModelo({
    @required this.listaZona,
  }) : super(elementos: listaZona);

  factory ListaZonaModelo.fromJson(List<dynamic> parsedJson) {
    List<ZonaModelo> _listaZona = List<ZonaModelo>();
    _listaZona = parsedJson.map((i) => ZonaModelo.fromJson(i)).toList();
    return ListaZonaModelo(listaZona: _listaZona);
  }
  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Las calles   / Rev 1
class CalleModelo extends CalleEntity implements ObjetoFila {
  int _calleOrigenId;
  int _calleZonaId;
  String _calleNombre;
  String _calleTipo;
  CalleModelo({
    @required int calleOrigenId,
    @required int calleZonaId,
    @required String calleNombre,
    @required String calleTipo,
  })  : this._calleOrigenId = calleOrigenId,
        this._calleZonaId = calleZonaId,
        this._calleNombre = calleNombre,
        this._calleTipo = calleTipo;
  int get calleOrigenId => _calleOrigenId;
  int get calleZonaId => _calleZonaId;
  String get calleNombre => _calleNombre;
  String get calleTipo => _calleTipo;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['calleOrigenId'] = _calleOrigenId;
    map['calleZonaId'] = _calleZonaId;
    map['calleNombre'] = _calleNombre;
    map['calleTipo'] = _calleTipo;
    return map;
  }

  @override
  CalleModelo.fromMapToObject(Map<String, dynamic> map) {
    this._calleOrigenId = map['calleOrigenId'];
    this._calleZonaId = map['calleZonaId'];
    this._calleNombre = map['calleNombre'];
    this._calleTipo = map['calleTipo'];
  }

  factory CalleModelo.fromJson(Map<String, dynamic> json) {
    return CalleModelo(
      calleOrigenId: int.parse(json['id_calle']),
      calleZonaId: int.parse(json['id_sector_entidad_calle']),
      calleNombre: json['detalle_calle'],
      calleTipo: json['tipo_calle'],
    );
  }
}

class ListaCalleModelo extends ObjetoLista implements ObjetoFila {
  final List<CalleModelo> listaCalle;
  ListaCalleModelo({
    @required this.listaCalle,
  }) : super(elementos: listaCalle);
  factory ListaCalleModelo.fromJson(List<dynamic> parsedJson) {
    List<CalleModelo> _listaCalle = List<CalleModelo>();
    _listaCalle = parsedJson.map((i) => CalleModelo.fromJson(i)).toList();
    return ListaCalleModelo(listaCalle: _listaCalle);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Calle esquina / Rev 1
class CalleEsquinaModelo extends CalleEsquinaEntity implements ObjetoFila {
  int _calleEsquinaOrigenId;
  int _calleEsquinaZonaId;
  String _calleEsquinaNombre;
  String _calleEsquinaTipo;
  CalleEsquinaModelo({
    @required int calleEsquinaOrigenId,
    @required String calleEsquinaTipo,
    @required int calleEsquinaZonaId,
    @required String calleEsquinaNombre,
  })  : this._calleEsquinaOrigenId = calleEsquinaOrigenId,
        this._calleEsquinaTipo = calleEsquinaTipo,
        this._calleEsquinaZonaId = calleEsquinaZonaId,
        this._calleEsquinaNombre = calleEsquinaNombre;

  int get calleEsquinaOrigenId => _calleEsquinaOrigenId;
  int get calleEsquinaZonaId => _calleEsquinaZonaId;
  String get calleEsquinaTipo => _calleEsquinaTipo;
  String get calleEsquinaNombre => _calleEsquinaNombre;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['calleEsquinaOrigenId'] = _calleEsquinaOrigenId;
    map['calleEsquinaZonaId'] = _calleEsquinaZonaId;
    map['calleEsquinaNombre'] = _calleEsquinaNombre;
    map['calleEsquinaTipo'] = _calleEsquinaTipo;
    return map;
  }

  @override
  CalleEsquinaModelo.fromMapToObject(Map<String, dynamic> map) {
    this._calleEsquinaZonaId = map['calleEsquinaZonaId'];
    this._calleEsquinaTipo = map['calleEsquinaTipo'];
    this._calleEsquinaOrigenId = map['calleEsquinaOrigenId'];
    this._calleEsquinaNombre = map['calleEsquinaNombre'];
  }

  factory CalleEsquinaModelo.fromJson(Map<String, dynamic> json) {
    return CalleEsquinaModelo(
      calleEsquinaOrigenId: int.parse(json['id_calle']),
      calleEsquinaZonaId: int.parse(json['id_sector_entidad_calle']),
      calleEsquinaNombre: json['detalle_calle'],
      calleEsquinaTipo: json['tipo_calle'],
    );
  }
}

class ListaCalleEsquinaModelo extends ObjetoLista implements ObjetoFila {
  final List<CalleEsquinaModelo> listaCalleEsquina;

  ListaCalleEsquinaModelo({
    @required this.listaCalleEsquina,
  }) : super(elementos: listaCalleEsquina);

  factory ListaCalleEsquinaModelo.fromJson(List<dynamic> parsedJson) {
    List<CalleEsquinaModelo> _listaCalleEsquina = List<CalleEsquinaModelo>();
    _listaCalleEsquina =
        parsedJson.map((i) => CalleEsquinaModelo.fromJson(i)).toList();
    return ListaCalleEsquinaModelo(listaCalleEsquina: _listaCalleEsquina);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Especie / Rev 1
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
      especieOrigenId: int.parse(json['id_especie']),
      especieNombreComun: json['detalle_especie'],
      especieNombreCientifico: json['detalle_cientifico_especie'],
      especieOrden: int.parse(json['orden_especie']),
      especieIcono: json['especie_icono'],
      especieHojaGenerica: json['especie_hoja'] ?? 'Falta link a la imagen',
      especieFotoGenerica: json['especie_foto'] ?? 'Falta link a la imagen',
      especieDescripcion: json['especie_descr'] ?? 'Falta la descripcion',
    );
  }
}

class ListaEspecieModelo extends ObjetoLista implements ObjetoFila {
  final List<EspecieModelo> listaEspecie;
  ListaEspecieModelo({
    @required this.listaEspecie,
  }) : super(elementos: listaEspecie);
  factory ListaEspecieModelo.fromJson(List<dynamic> parsedJson) {
    List<EspecieModelo> _listaEspecie = List<EspecieModelo>();
    _listaEspecie = parsedJson.map((i) => EspecieModelo.fromJson(i)).toList();
    return ListaEspecieModelo(listaEspecie: _listaEspecie);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
//OJO: Estado General  / Rev 1

class EstadoGeneralModelo extends EstadoGeneralEntity implements ObjetoFila {
  int _estadoGeneralOrigenId;
  String _estadoGeneralDesc;
  EstadoGeneralModelo({
    @required int estadoGeneralOrigenId,
    @required String estadoGeneralDesc,
  })  : this._estadoGeneralOrigenId = estadoGeneralOrigenId,
        this._estadoGeneralDesc = estadoGeneralDesc;
  int get estadoGeneralOrigenId => _estadoGeneralOrigenId;
  String get estadoGeneralDesc => _estadoGeneralDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['estadoGeneralOrigenId'] = _estadoGeneralOrigenId;
    map['estadoGeneralDesc'] = _estadoGeneralDesc;
    return map;
  }

  @override
  EstadoGeneralModelo.fromMapToObject(Map<String, dynamic> map) {
    this._estadoGeneralOrigenId = map['estadoGeneralOrigenId'];
    this._estadoGeneralDesc = map['estadoGeneralDesc'];
  }
  factory EstadoGeneralModelo.fromJson(Map<String, dynamic> json) {
    return EstadoGeneralModelo(
      estadoGeneralOrigenId: int.parse(json['id_estado_general']),
      estadoGeneralDesc: json['detalle_estado_general'],
    );
  }
}

class ListaEstadoGeneralModelo extends ObjetoLista implements ObjetoFila {
  final List<EstadoGeneralModelo> listaEstadoGeneral;
  ListaEstadoGeneralModelo({
    @required this.listaEstadoGeneral,
  }) : super(elementos: listaEstadoGeneral);
  factory ListaEstadoGeneralModelo.fromJson(List<dynamic> parsedJson) {
    List<EstadoGeneralModelo> _listaEstadoGeneral = List<EstadoGeneralModelo>();
    _listaEstadoGeneral =
        parsedJson.map((i) => EstadoGeneralModelo.fromJson(i)).toList();
    return ListaEstadoGeneralModelo(listaEstadoGeneral: _listaEstadoGeneral);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
//OJO: Estado Sanitario   / Rev 1

class EstadoSanitarioModelo extends EstadoSanitarioEntity
    implements ObjetoFila {
  int _estadoSanitarioOrigenId;
  String _estadoSanitarioDesc;
  EstadoSanitarioModelo({
    @required int estadoSanitarioOrigenId,
    @required String estadoSanitarioDesc,
  })  : this._estadoSanitarioOrigenId = estadoSanitarioOrigenId,
        this._estadoSanitarioDesc = estadoSanitarioDesc;
  int get estadoSanitarioOrigenId => _estadoSanitarioOrigenId;
  String get estadoSanitarioDesc => _estadoSanitarioDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['estadoSanitarioOrigenId'] = _estadoSanitarioOrigenId;
    map['estadoSanitarioDesc'] = _estadoSanitarioDesc;
    return map;
  }

  @override
  EstadoSanitarioModelo.fromMapToObject(Map<String, dynamic> map) {
    this._estadoSanitarioOrigenId = map['estadoSanitarioOrigenId'];
    this._estadoSanitarioDesc = map['estadoSanitarioDesc'];
  }

  factory EstadoSanitarioModelo.fromJson(Map<String, dynamic> json) {
    return EstadoSanitarioModelo(
      estadoSanitarioOrigenId: int.parse(json['id_estado_sanitario']),
      estadoSanitarioDesc: json['detalle_estado_sanitario'],
    );
  }
}

class ListaEstadoSanitarioModelo extends ObjetoLista implements ObjetoFila {
  final List<EstadoSanitarioModelo> listaEstadoSanitario;

  ListaEstadoSanitarioModelo({
    @required this.listaEstadoSanitario,
  }) : super(elementos: listaEstadoSanitario);

  factory ListaEstadoSanitarioModelo.fromJson(List<dynamic> parsedJson) {
    List<EstadoSanitarioModelo> _listaEstadoSanitario =
        List<EstadoSanitarioModelo>();
    _listaEstadoSanitario =
        parsedJson.map((i) => EstadoSanitarioModelo.fromJson(i)).toList();
    return ListaEstadoSanitarioModelo(
        listaEstadoSanitario: _listaEstadoSanitario);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

// implements ObjetoFila
//_propiedades
// : this._ = propiedades
// get
//  @override
//  int idFila;
// toMap
// fromMaP
// factory from json
// class list

//OJO: Inclinacon tronco   / Rev 1

class InclinacionTroncoModelo extends InclinacionTroncoEntity
    implements ObjetoFila {
  int _inclinacionTroncoOrigenId;
  String _inclinacionTroncoDesc;
  InclinacionTroncoModelo({
    @required int inclinacionTroncoOrigenId,
    @required String inclinacionTroncoDesc,
  })  : this._inclinacionTroncoOrigenId = inclinacionTroncoOrigenId,
        this._inclinacionTroncoDesc = inclinacionTroncoDesc;
  int get inclinacionTroncoOrigenId => _inclinacionTroncoOrigenId;
  String get inclinacionTroncoDesc => _inclinacionTroncoDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['inclinacionTroncoOrigenId'] = _inclinacionTroncoOrigenId;
    map['inclinacionTroncoDesc'] = _inclinacionTroncoDesc;
    return map;
  }

  @override
  InclinacionTroncoModelo.fromMapToObject(Map<String, dynamic> map) {
    this._inclinacionTroncoOrigenId = map['inclinacionTroncoOrigenId'];
    this._inclinacionTroncoDesc = map['inclinacionTroncoDesc'];
  }

  factory InclinacionTroncoModelo.fromJson(Map<String, dynamic> json) {
    return InclinacionTroncoModelo(
      inclinacionTroncoOrigenId: int.parse(json['id_inclinacion_tronco']),
      inclinacionTroncoDesc: json['detalle_inclinacion_tronco'],
    );
  }
}

class ListaInclinacionTroncoModelo extends ObjetoLista implements ObjetoFila {
  final List<InclinacionTroncoModelo> listaInclinacionTronco;

  ListaInclinacionTroncoModelo({
    @required this.listaInclinacionTronco,
  }) : super(elementos: listaInclinacionTronco);

  factory ListaInclinacionTroncoModelo.fromJson(List<dynamic> parsedJson) {
    List<InclinacionTroncoModelo> _listaInclinacionTronco =
        List<InclinacionTroncoModelo>();
    _listaInclinacionTronco =
        parsedJson.map((i) => InclinacionTroncoModelo.fromJson(i)).toList();
    return ListaInclinacionTroncoModelo(
        listaInclinacionTronco: _listaInclinacionTronco);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
//OJO: Orientación inclinación   / Rev 1

class OrientacionInclinacionModelo extends OrientacionInclinacionEntity
    implements ObjetoFila {
  int _orientacionInclinacionOrigenId;
  String _orientacionInclinacionDesc;
  OrientacionInclinacionModelo({
    @required int orientacionInclinacionOrigenId,
    @required String orientacionInclinacionDesc,
  })  : this._orientacionInclinacionOrigenId = orientacionInclinacionOrigenId,
        this._orientacionInclinacionDesc = orientacionInclinacionDesc;

  int get orientacionInclinacionOrigenId => _orientacionInclinacionOrigenId;
  String get orientacionInclinacionDesc => _orientacionInclinacionDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['orientacionInclinacionOrigenId'] = _orientacionInclinacionOrigenId;
    map['orientacionInclinacionDesc'] = _orientacionInclinacionDesc;
    return map;
  }

  @override
  OrientacionInclinacionModelo.fromMapToObject(Map<String, dynamic> map) {
    this._orientacionInclinacionOrigenId =
        map['orientacionInclinacionOrigenId'];
    this._orientacionInclinacionDesc = map['orientacionInclinacionDesc'];
  }

  factory OrientacionInclinacionModelo.fromJson(Map<String, dynamic> json) {
    return OrientacionInclinacionModelo(
      orientacionInclinacionOrigenId:
          int.parse(json['id_orientacion_inclinacion']),
      orientacionInclinacionDesc: json['detalle_orientacion_inclinacion'],
    );
  }
}

class ListaOrientacionInclinacionModelo extends ObjetoLista
    implements ObjetoFila {
  final List<OrientacionInclinacionModelo> listaOrientacionInclinacion;

  ListaOrientacionInclinacionModelo({
    @required this.listaOrientacionInclinacion,
  }) : super(elementos: listaOrientacionInclinacion);

  factory ListaOrientacionInclinacionModelo.fromJson(List<dynamic> parsedJson) {
    List<OrientacionInclinacionModelo> _listaOrientacionInclinacion =
        List<OrientacionInclinacionModelo>();
    _listaOrientacionInclinacion = parsedJson
        .map((i) => OrientacionInclinacionModelo.fromJson(i))
        .toList();
    return ListaOrientacionInclinacionModelo(
        listaOrientacionInclinacion: _listaOrientacionInclinacion);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Oaccion Obs    / Rev 1

class AccionObsModelo extends AccionObsEntity implements ObjetoFila {
  int _accionObsOrigenId;
  String _accionObsDesc;
  int _accionObsOrden;

  AccionObsModelo({
    @required int accionObsOrigenId,
    @required String accionObsDesc,
    @required int accionObsOrden,
  })  : this._accionObsOrigenId = accionObsOrigenId,
        this._accionObsDesc = accionObsDesc,
        this._accionObsOrden = accionObsOrden;

  int get accionObsOrigenId => _accionObsOrigenId;
  String get accionObsDesc => _accionObsDesc;
  int get accionObsOrden => _accionObsOrden;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['accionObsOrigenId'] = _accionObsOrigenId;
    map['accionObsDesc'] = _accionObsDesc;
    map['accionObsOrden'] = _accionObsOrden;
    return map;
  }

  @override
  AccionObsModelo.fromMapToObject(Map<String, dynamic> map) {
    this._accionObsOrigenId = map['accionObsOrigenId'];
    this._accionObsDesc = map['accionObsDesc'];
    this._accionObsOrden = map['accionObsOrden'];
  }

  factory AccionObsModelo.fromJson(Map<String, dynamic> json) {
    return AccionObsModelo(
      accionObsOrigenId: int.parse(json['id_accion_obs']),
      accionObsDesc: json['detalle_accion_obs'],
      accionObsOrden: int.parse(json['orden_accion_obs'] ?? '0'),
    );
  }
}

class ListaAccionObsModelo extends ObjetoLista implements ObjetoFila {
  final List<AccionObsModelo> listaAccionObs;

  ListaAccionObsModelo({
    @required this.listaAccionObs,
  }) : super(elementos: listaAccionObs);

  factory ListaAccionObsModelo.fromJson(List<dynamic> parsedJson) {
    List<AccionObsModelo> _listaAccionObs = List<AccionObsModelo>();
    _listaAccionObs =
        parsedJson.map((i) => AccionObsModelo.fromJson(i)).toList();
    return ListaAccionObsModelo(listaAccionObs: _listaAccionObs);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Usuario     / Rev 1

class UsuarioModelo extends UsuarioEntity implements ObjetoFila {
  int _usuarioOrigenId;
  String _usuarioGUI;
  int _usuarioCliente;
  int _usuarioRol;
  String _usuarioNombre;
  String _usuarioApellido;
  String _usuarioEmail;
  String _usuarioCreacion;
  String _usuarioActividad;
  UsuarioModelo({
    @required int usuarioOrigenId,
    @required String usuarioGUI,
    @required int usuarioCliente,
    @required int usuarioRol,
    @required String usuarioNombre,
    @required String usuarioApellido,
    @required String usuarioEmail,
    @required String usuarioCreacion,
    @required String usuarioActividad,
  })  : this._usuarioOrigenId = usuarioOrigenId,
        this._usuarioGUI = usuarioGUI,
        this._usuarioCliente = usuarioCliente,
        this._usuarioRol = usuarioRol,
        this._usuarioNombre = usuarioNombre,
        this._usuarioApellido = usuarioApellido,
        this._usuarioEmail = usuarioEmail,
        this._usuarioCreacion = usuarioCreacion,
        this._usuarioActividad = usuarioActividad;

  int get usuarioOrigenId => _usuarioOrigenId;
  String get usuarioGUI => _usuarioGUI;
  int get usuarioCliente => _usuarioCliente;
  int get usuarioRol => _usuarioRol;
  String get usarioNombre => _usuarioNombre;
  String get usuarioApellido => _usuarioApellido;
  String get usuarioEmail => _usuarioEmail;
  String get usuarioCreacion => _usuarioCreacion;
  String get usuarioActividad => _usuarioActividad;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['usuarioOrigenId'] = _usuarioOrigenId;
    map['usuarioGUI'] = _usuarioGUI;
    map['usuarioCliente'] = _usuarioCliente;
    map['usuarioRol'] = _usuarioRol;
    map['usuarioNombre'] = _usuarioNombre;
    map['usuarioApellido'] = _usuarioApellido;
    map['usuarioEmail'] = _usuarioEmail;
    map['usuarioCreacion'] = _usuarioCreacion;
    map['usuarioActividad'] = _usuarioActividad;
    return map;
  }

  @override
  UsuarioModelo.fromMapToObject(Map<String, dynamic> map) {
    this._usuarioOrigenId = map['usuarioOrigenId'];
    this._usuarioGUI = map['usuarioGUI'];
    this._usuarioCliente = map['usuarioCliente'];
    this._usuarioRol = map['usuarioRol'];
    this._usuarioNombre = map['usuarioNombre'];
    this._usuarioApellido = map['usuarioApellido'];
    this._usuarioEmail = map['usuarioEmail'];
    this._usuarioCreacion = map['usuarioCreacion'];
    this._usuarioActividad = map['usuarioActividad'];
  }

  factory UsuarioModelo.fromJson(Map<String, dynamic> json) {
    return UsuarioModelo(
      usuarioOrigenId: int.parse(json['id_usuario']),
      usuarioGUI: 'NO SETEADO',
      usuarioCliente: int.parse(json['id_entidad_usuario']),
      usuarioRol: int.parse(json['id_perfil_user_usuario']),
      usuarioNombre: json['nombre_usuario'],
      usuarioApellido: json['apellido_usuario'],
      usuarioEmail: 'generico@provisional.cl',
      usuarioCreacion: 'No definido',
      usuarioActividad: json['activo_usuario'],
    );
  }
}

class ListaUsuarioModelo extends ObjetoLista implements ObjetoFila {
  final List<UsuarioModelo> listaUsuario;
  ListaUsuarioModelo({
    @required this.listaUsuario,
  }) : super(elementos: listaUsuario);
  factory ListaUsuarioModelo.fromJson(List<dynamic> parsedJson) {
    List<UsuarioModelo> _listaUsuario = List<UsuarioModelo>();
    _listaUsuario = parsedJson.map((i) => UsuarioModelo.fromJson(i)).toList();
    return ListaUsuarioModelo(listaUsuario: _listaUsuario);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
//OJO: Hacer enfermedad

//OJO: Agente Patogeno     / Rev 1

class AgentePatogenoModelo extends AgentePatogenoEntity implements ObjetoFila {
  int _agentePatogenoOrigenId;
  String _agentePatogenoDesc;
  AgentePatogenoModelo({
    @required int agentePatogenoOrigenId,
    @required String agentePatogenoDesc,
  })  : this._agentePatogenoOrigenId = agentePatogenoOrigenId,
        this._agentePatogenoDesc = agentePatogenoDesc;
  int get agentePatogenoOrigenId => _agentePatogenoOrigenId;
  String get agentePatogenoDesc => _agentePatogenoDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['agentePatogenoOrigenId'] = _agentePatogenoOrigenId;
    map['agentePatogenoDesc'] = _agentePatogenoDesc;
    return map;
  }

  @override
  AgentePatogenoModelo.fromMapToObject(Map<String, dynamic> map) {
    this._agentePatogenoOrigenId = map['agentePatogenoOrigenId'];
    this._agentePatogenoDesc = map['agentePatogenoDesc'];
  }

  factory AgentePatogenoModelo.fromJson(Map<String, dynamic> json) {
    return AgentePatogenoModelo(
      agentePatogenoOrigenId: int.parse(json['id_agentes_patogenos']),
      agentePatogenoDesc: json['detalle_agentes_patogenos'],
    );
  }
}

class ListaAgentePatogenoModelo extends ObjetoLista implements ObjetoFila {
  final List<AgentePatogenoModelo> listaAgentePatogeno;
  ListaAgentePatogenoModelo({
    @required this.listaAgentePatogeno,
  }) : super(elementos: listaAgentePatogeno);
  factory ListaAgentePatogenoModelo.fromJson(List<dynamic> parsedJson) {
    List<AgentePatogenoModelo> _listaAgentePatogeno =
        List<AgentePatogenoModelo>();
    _listaAgentePatogeno =
        parsedJson.map((i) => AgentePatogenoModelo.fromJson(i)).toList();
    return ListaAgentePatogenoModelo(listaAgentePatogeno: _listaAgentePatogeno);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Lugar Plaga     / Rev 1

class LugarPlagaModelo extends LugarPlagaEntity implements ObjetoFila {
  int _lugarPlagaOrigenId;
  String _lugarPlagaDesc;
  LugarPlagaModelo({
    @required int lugarPlagaOrigenId,
    @required String lugarPlagaDesc,
  })  : this._lugarPlagaOrigenId = lugarPlagaOrigenId,
        this._lugarPlagaDesc = lugarPlagaDesc;
  int get lugarPlagaOrigenId => _lugarPlagaOrigenId;
  String get lugarPlagaDesc => _lugarPlagaDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['lugarPlagaOrigenId'] = _lugarPlagaOrigenId;
    map['lugarPlagaDesc'] = _lugarPlagaDesc;
    return map;
  }

  @override
  LugarPlagaModelo.fromMapToObject(Map<String, dynamic> map) {
    this._lugarPlagaOrigenId = map['lugarPlagaOrigenId'];
    this._lugarPlagaDesc = map['lugarPlagaDesc'];
  }

  factory LugarPlagaModelo.fromJson(Map<String, dynamic> json) {
    return LugarPlagaModelo(
      lugarPlagaOrigenId: int.parse(json['id_lugar_plaga']),
      lugarPlagaDesc: json['detalle_lugar_plaga'],
    );
  }
}

class ListaLugarPlagaModelo extends ObjetoLista implements ObjetoFila {
  final List<LugarPlagaModelo> listaLugarPlaga;
  ListaLugarPlagaModelo({
    @required this.listaLugarPlaga,
  }) : super(elementos: listaLugarPlaga);
  factory ListaLugarPlagaModelo.fromJson(List<dynamic> parsedJson) {
    List<LugarPlagaModelo> _listaLugarPlaga = List<LugarPlagaModelo>();
    _listaLugarPlaga =
        parsedJson.map((i) => LugarPlagaModelo.fromJson(i)).toList();
    return ListaLugarPlagaModelo(listaLugarPlaga: _listaLugarPlaga);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

//OJO: Plaga     / Rev 1

class PlagaModelo extends PlagaEntity implements ObjetoFila {
  int _plagaOrigenId;
  String _plagaDesc;
  PlagaModelo({
    @required int plagaOrigenId,
    @required String plagaDesc,
  })  : this._plagaOrigenId = plagaOrigenId,
        this._plagaDesc = plagaDesc;
  int get plagaOrigenId => _plagaOrigenId;
  String get plagaDesc => _plagaDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['plagaOrigenId'] = _plagaOrigenId;
    map['plagaDesc'] = _plagaDesc;
    return map;
  }

  @override
  PlagaModelo.fromMapToObject(Map<String, dynamic> map) {
    this._plagaOrigenId = map['plagaOrigenId'];
    this._plagaDesc = map['plagaDesc'];
  }

  factory PlagaModelo.fromJson(Map<String, dynamic> json) {
    return PlagaModelo(
      plagaOrigenId: int.parse(json['id_plagas']),
      plagaDesc: json['detalle_plagas'],
    );
  }
}

class ListaPlagaModelo extends ObjetoLista implements ObjetoFila {
  final List<PlagaModelo> listaPlaga;

  ListaPlagaModelo({
    @required this.listaPlaga,
  }) : super(elementos: listaPlaga);

  factory ListaPlagaModelo.fromJson(List<dynamic> parsedJson) {
    List<PlagaModelo> _listaPlaga = List<PlagaModelo>();
    _listaPlaga = parsedJson.map((i) => PlagaModelo.fromJson(i)).toList();
    return ListaPlagaModelo(listaPlaga: _listaPlaga);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

class SintomaModelo extends SintomaEntity implements ObjetoFila {
  int _sintomaOrigenId;
  String _sintomaDesc;
  SintomaModelo({
    @required int sintomaOrigenId,
    @required String sintomaDesc,
  })  : this._sintomaOrigenId = sintomaOrigenId,
        this._sintomaDesc = sintomaDesc;
  int get plagaOrigenId => _sintomaOrigenId;
  String get plagaDesc => _sintomaDesc;

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['sintomaOrigenId'] = _sintomaOrigenId;
    map['sintomaDesc'] = _sintomaDesc;
    return map;
  }

  @override
  SintomaModelo.fromMapToObject(Map<String, dynamic> map) {
    this._sintomaOrigenId = map['sintomaOrigenId'];
    this._sintomaDesc = map['sintomaDesc'];
  }

  factory SintomaModelo.fromJson(Map<String, dynamic> json) {
    return SintomaModelo(
      sintomaOrigenId: int.parse(json['id_sintoma']),
      sintomaDesc: json['detalle_sintoma'],
    );
  }
}

class ListaSintomaModelo extends ObjetoLista implements ObjetoFila {
  final List<SintomaModelo> listaSintoma;

  ListaSintomaModelo({
    @required this.listaSintoma,
  }) : super(elementos: listaSintoma);

  factory ListaSintomaModelo.fromJson(List<dynamic> parsedJson) {
    List<SintomaModelo> _listaSintoma = List<SintomaModelo>();
    _listaSintoma = parsedJson.map((i) => SintomaModelo.fromJson(i)).toList();
    return ListaSintomaModelo(listaSintoma: _listaSintoma);
  }

  @override
  int idFila;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
