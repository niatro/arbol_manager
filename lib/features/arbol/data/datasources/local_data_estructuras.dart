import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final EsquemaDataDeSQL esquema = EsquemaDataDeSQL();
ClienteModelo cliente(Map<String, dynamic> ob) {
  return ClienteModelo.fromMapToObject(ob);
}

ZonaModelo zona(Map<String, dynamic> ob) {
  return ZonaModelo.fromMapToObject(ob);
}

CalleModelo calle(Map<String, dynamic> ob) {
  return CalleModelo.fromMapToObject(ob);
}

CalleEsquinaModelo calleEsquina(Map<String, dynamic> ob) {
  return CalleEsquinaModelo.fromMapToObject(ob);
}

EstadoGeneralModelo estadoGeneral(Map<String, dynamic> ob) {
  return EstadoGeneralModelo.fromMapToObject(ob);
}

EstadoSanitarioModelo estadoSanitario(Map<String, dynamic> ob) {
  return EstadoSanitarioModelo.fromMapToObject(ob);
}

InclinacionTroncoModelo inclinacionTronco(Map<String, dynamic> ob) {
  return InclinacionTroncoModelo.fromMapToObject(ob);
}

OrientacionInclinacionModelo orientacionInclinacion(Map<String, dynamic> ob) {
  return OrientacionInclinacionModelo.fromMapToObject(ob);
}

AccionObsModelo accionObs(Map<String, dynamic> ob) {
  return AccionObsModelo.fromMapToObject(ob);
}

UsuarioModelo usuario(Map<String, dynamic> ob) {
  return UsuarioModelo.fromMapToObject(ob);
}

AgentePatogenoModelo agentePatogeno(Map<String, dynamic> ob) {
  return AgentePatogenoModelo.fromMapToObject(ob);
}

LugarPlagaModelo lugarPlaga(Map<String, dynamic> ob) {
  return LugarPlagaModelo.fromMapToObject(ob);
}

PlagaModelo plaga(Map<String, dynamic> ob) {
  return PlagaModelo.fromMapToObject(ob);
}

SintomaModelo sintoma(Map<String, dynamic> ob) {
  return SintomaModelo.fromMapToObject(ob);
}

EspecieModelo especie(Map<String, dynamic> ob) {
  return EspecieModelo.fromMapToObject(ob);
}

final List<Map> nombreTablasFormBD = [
  {
    'nombre': esquema.cliente.nombreTabla,
    'orden': esquema.cliente.clienteOrigenId,
    'objeto': cliente,
  },
  {
    'nombre': esquema.zona.nombreTabla,
    'orden': esquema.zona.zonaOrigenId,
    'objeto': zona,
  },
  {
    'nombre': esquema.calle.nombreTabla,
    'orden': esquema.calle.calleNombre,
    'objeto': calle,
  },
  {
    'nombre': esquema.calleEsquina.nombreTabla,
    'orden': esquema.calleEsquina.calleEsquinaOrigenId,
    'objeto': calleEsquina,
  },
  {
    'nombre': esquema.estadoGeneral.nombreTabla,
    'orden': esquema.estadoGeneral.estadoGeneralOrigenId,
    'objeto': estadoGeneral,
  },
  {
    'nombre': esquema.estadoSanitario.nombreTabla,
    'orden': esquema.estadoSanitario.estadoSanitarioOrigenId,
    'objeto': estadoSanitario,
  },
  {
    'nombre': esquema.inclinacionTronco.nombreTabla,
    'orden': esquema.inclinacionTronco.inclinacionTroncoId,
    'objeto': inclinacionTronco,
  },
  {
    'nombre': esquema.orientacionInclinacion.nombreTabla,
    'orden': esquema.orientacionInclinacion.orientacionInclinacionOrigenId,
    'objeto': orientacionInclinacion,
  },
  {
    'nombre': esquema.accionObs.nombreTabla,
    'orden': esquema.accionObs.accionObsOrden,
    'objeto': accionObs,
  },
  {
    'nombre': esquema.usuario.nombreTabla,
    'orden': esquema.usuario.usuarioOrigenId,
    'objeto': usuario,
  },
  {
    'nombre': esquema.agentesPatogenos.nombreTabla,
    'orden': esquema.agentesPatogenos.agentePatogenoDesc,
    'objeto': agentePatogeno,
  },
  {
    'nombre': esquema.lugarPlaga.nombreTabla,
    'orden': esquema.lugarPlaga.lugarPlagaId,
    'objeto': lugarPlaga,
  },
  {
    'nombre': esquema.plagas.nombreTabla,
    'orden': esquema.plagas.plagaDesc,
    'objeto': plaga,
  },
  {
    'nombre': esquema.sintomas.nombreTabla,
    'orden': esquema.sintomas.sintomaDesc,
    'objeto': sintoma,
  },
  {
    'nombre': esquema.especie.nombreTabla,
    'orden': esquema.especie.especieOrden,
    'objeto': especie,
  },
];

class EsquemaDataDeSQL {
  final EsquemaCliente cliente = EsquemaCliente();
  final EsquemaZona zona = EsquemaZona();
  final EsquemaCalle calle = EsquemaCalle();
  final EsquemaCalleEsquina calleEsquina = EsquemaCalleEsquina();
  final EsquemaEspecie especie = EsquemaEspecie();
  final EsquemaEstadoGeneral estadoGeneral = EsquemaEstadoGeneral();
  final EsquemaEstadoSanitario estadoSanitario = EsquemaEstadoSanitario();
  final EsquemaInclinacionTronco inclinacionTronco = EsquemaInclinacionTronco();
  final EsquemaOrientacionInclinacion orientacionInclinacion =
      EsquemaOrientacionInclinacion();
  final EsquemaAccionObs accionObs = EsquemaAccionObs();
  final EsquemaUsuario usuario = EsquemaUsuario();
  final EsquemaAgentesPatogenos agentesPatogenos = EsquemaAgentesPatogenos();
  final EsquemaLugarPlaga lugarPlaga = EsquemaLugarPlaga();
  final EsquemaPlagas plagas = EsquemaPlagas();
  final EsquemaSintomas sintomas = EsquemaSintomas();
}

class EsquemaCliente {
  String nombreTabla = 'tablaCliente';
  String clienteId = 'clienteId';
  String clienteOrigenId = 'clienteOrigenId';
  String clienteNombre = 'clienteNombre';
}

class EsquemaZona {
  String nombreTabla = 'tablaZona';
  String zonaId = 'zonaId';
  String zonaOrigenId = 'zonaOrigenId';
  String zonaNombre = 'zonaNombre';
  String foreignKey = 'clienteId';
}

class EsquemaCalle {
  String nombreTabla = 'tablaCalle';
  String calleId = 'calleId';
  String calleOrigenId = 'calleOrigenId';
  String calleZonaId = 'calleZonaId';
  String calleNombre = 'calleNombre';
  String calleTipo = 'calleTipo';
  String foreignKey = 'clienteId';
}

class EsquemaCalleEsquina {
  String nombreTabla = 'tablaCalleEsquina';
  String calleEsquinaId = 'calleEsquinaId';
  String calleEsquinaOrigenId = 'calleEsquinaOrigenId';
  String calleEsquinaZonaId = 'calleEsquinaZonaId';
  String calleEsquinaNombre = 'calleEsquinaNombre';
  String calleEsquinaTipo = 'calleEsquinaTipo';
  String foreignKey = 'clienteId';
}

class EsquemaEspecie {
  String nombreTabla = 'tablaEspecie';
  String especieId = 'especieId';
  String especieOrigenId = 'especieOrigenId';
  String especieNombreComun = 'especieNombreComun';
  String especieNombreCientifico = 'especieNombreCientifico';
  String especieOrden = 'especieOrden';
  String especieIcono = 'especieIcono';
  String especieHojaGenerica = 'especieHojaGenerica';
  String especieFotoGenerica = 'especieFotoGenerica';
  String especieDescripcion = 'especieDescripcion';
}

class EsquemaEstadoGeneral {
  String nombreTabla = 'tablaEstadoGeneral';
  String estadoGeneralId = 'estadoGeneralId';
  String estadoGeneralOrigenId = 'estadoGeneralOrigenId';
  String estadoGeneralDesc = 'estadoGeneralDesc';
}

class EsquemaEstadoSanitario {
  String nombreTabla = 'tablaEstadoSanitario';
  String estadoSanitarioId = 'estadoSanitarioId';
  String estadoSanitarioOrigenId = 'estadoSanitarioOrigenId';
  String estadoSanitarioDesc = 'estadoSanitarioDesc';
}

class EsquemaInclinacionTronco {
  String nombreTabla = 'tablaInclinacionTronco';
  String inclinacionTroncoId = 'inclinacionTroncoId';
  String inclinacionTroncoOrigenId = 'inclinacionTroncoOrigenId';
  String inclinacionTroncoDesc = 'inclinacionTroncoDesc';
}

class EsquemaOrientacionInclinacion {
  String nombreTabla = 'tablaOrientacionInclinacion';
  String orientacionInclinacionId = 'orientacionInclinacionId';
  String orientacionInclinacionOrigenId = 'orientacionInclinacionOrigenId';
  String orientacionInclinacionDesc = 'orientacionInclinacionDesc';
}

class EsquemaAccionObs {
  String nombreTabla = 'tablaAccionObs';
  String accionObsId = 'accionObsId';
  String accionObsOrigenId = 'accionObsOrigenId';
  String accionObsDesc = 'accionObsDesc';
  String accionObsOrden = 'accionObsOrden';
}

class EsquemaUsuario {
  String nombreTabla = 'tablaUsuario';
  String usuarioId = 'usuarioId';
  String usuarioOrigenId = 'usuarioOrigenId';
  String usuarioGUI = 'usuarioGUI';
  String usuarioCliente = 'usuarioCliente';
  String usuarioRol = 'usuarioRol';
  String usuarioNombre = 'usuarioNombre';
  String usuarioApellido = 'usuarioApellido';
  String usuarioEmail = 'usuarioEmail';
  String usuarioCreacion = 'usuarioCreacion';
  String usuarioActividad = 'usuarioActividad';
  String foreignKey = 'clienteId';
}

class EsquemaAgentesPatogenos {
  String nombreTabla = 'tablaAgentesPatogenos';
  String agentesPatogenosId = 'agentesPatogenosId';
  String agentePatogenoOrigenId = 'agentePatogenoOrigenId';
  String agentePatogenoDesc = 'agentePatogenoDesc';
}

class EsquemaLugarPlaga {
  String nombreTabla = 'tablaLugarPlaga';
  String lugarPlagaId = 'lugarPlagaId';
  String lugarPlagaOrigenId = 'lugarPlagaOrigenId';
  String lugarPlagaDesc = 'lugarPlagaDesc';
}

class EsquemaPlagas {
  String nombreTabla = 'tablaPlagas';
  String plagaId = 'plagaId';
  String plagaOrigenId = 'plagaOrigenId';
  String plagaDesc = 'plagaDesc';
}

class EsquemaSintomas {
  String nombreTabla = 'tablaSintoma';
  String sintomaId = 'sintomaId';
  String sintomaOrigenId = 'sintomaOrigenId';
  String sintomaDesc = 'sintomaDesc';
}
