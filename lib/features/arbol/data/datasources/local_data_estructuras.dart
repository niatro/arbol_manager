const Map<String, Map> TABLAS_BD = {
  'TABLA_CLIENTE': {
    'NOMBRE_TABLA': 'tablaCliente',
    'CLIENTE_ID': 'clienteId',
    'CLIENTE_NOMBRE': 'clienteNombre',
  },
  'TABLA_ZONA': {
    'NOMBRE_TABLA': 'tablaZona',
    'ZONA_ID': 'zonaId',
    'ZONA_NOMBRE': 'zonaNombre',
  }
};

//Constantes en tabla cliente 🙋
const String TABLA_CLIENTE = 'tablaCliente';
const String CLIENTE_ID = 'clienteId';
const String CLIENTE_NOMBRE = 'clienteNombre';
//Constantes en tabla zona 🙋
const String TABLA_ZONA = 'tablaZona';
const String ZONA_ID = 'zonaId';
const String ZONA_NOMBRE = 'zonaNombre';

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
  String foreignKey = 'clienteId';
}

class EsquemaCalleEsquina {
  String nombreTabla = 'tablaCalleEsquina';
  String calleEsquinaId = 'calleEsquinaId';
  String calleEsquinaOrigenId = 'calleEsquinaorigenId';
  String calleEsquinaZonaId = 'calleEsquinaZonaId';
  String calleEsquinaNombre = 'calleEsquinaNombre';
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
  String estadoGeneralIdDesc = 'estadoGeneralIdDesc';
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
  String inclinacionDesc = 'inclinacionDesc';
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
  String usuarioNombre = 'usarioNombre';
  String usuarioApellido = 'usuarioApellido';
  String usuarioEmail = 'usuarioEmail';
  String usuarioCreacion = 'usuarioCreacion';
  String usuarioActividad = 'usuarioActividad';
  String foreignKey = 'clienteId';
}

class EsquemaAgentesPatogenos {
  String nombreTabla = 'tablaAgentesPatogenos';
  String agentesPatogenosId = 'agentesPatogenosId';
  String agentesPatogenosOrigenId = 'agentesPatogenosOrigenId';
  String agentesPatogenosDesc = 'agentesPatogenosDesc';
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
