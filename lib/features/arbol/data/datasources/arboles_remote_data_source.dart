import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutterapparbol/core/constants/server_prueba.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'local_data_estructuras.dart';

abstract class ArbolesRemoteDataSource {
  /// Va al sector de pruebas y ejecuta un archivo mediante un método post
  ///   http://35.224.182.198 y si funciona obtiene [ArbolesEntityModelo] si no
  ///  Arroja una excepcion [ServiceException] para todos los errores
  ///  Finalmente en implementación debería ir a  http://35.225.91.186
  //OJO: no implementado
  Future<ArbolesEntityModelo> getArbolesCercanosRemoteData(
      {LatLng coordenadas});

  // Esto esta mal porque no se necesita devolver una entidad de ListaDeArboles
  // Solo necesito que la operación se haya realizado correctamente
  //OJO: no implementado
  Future<bool> grabarArboleRemoteData({ArbolEntity arbol});
  //OJO: no implementado
  Future<bool> verificarIdNFCRemoteData({String idNFC});
  //OJO: no implementado
  Future<ArbolesEntityModelo> getArbolPorIdNFCRemoteData({String idNFC});
  Future<ObjetoLista> llenarObjetoListaDesdeHttp({String tabla});
  Future<bool> actualizarBaseDatosFormularios();
}

class ArbolesRemoteDataSourceImpl extends ArbolesRemoteDataSource {
  final http.Client client;
  ArbolesRemoteDataSourceImpl({@required this.client});
  final EsquemaDataDeSQL referencia = EsquemaDataDeSQL();
  final String _url = urlPruebas;
  FormLocalSourceSqlImpl _databaseHelper = FormLocalSourceSqlImpl();

  @override
  Future<ArbolesEntityModelo> getArbolesCercanosRemoteData(
      {LatLng coordenadas}) async {
    final response = await client.post(
      _url + "/bd/getArbolPorCoordenadas.php",
      body: {
        "latitud": coordenadas.latitude.toString(),
        "longitud": coordenadas.longitude.toString(),
      },
    );
    return _getArbolesOrFailureDeAcuerdoToServerResponse(response);
  }

  @override
  Future<ArbolesEntityModelo> getArbolPorIdNFCRemoteData({String idNFC}) async {
    final response = await client.post(
      _url + "/bd/getArbolPorIdNFC.php",
      body: {
        "idNFC": idNFC,
      },
    );
    return _getArbolesOrFailureDeAcuerdoToServerResponse(response);
  }

  ArbolesEntityModelo _getArbolesOrFailureDeAcuerdoToServerResponse(
      http.Response response) {
    if (response.statusCode == 200) {
      final List<Map> jsonMaped =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      final ArbolesEntityModelo arbolesEntityModelo =
          ArbolesEntityModelo.fromJson(parsedListMapFromJson: jsonMaped);
      return arbolesEntityModelo;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> verificarIdNFCRemoteData({String idNFC}) async {
    final response = await client.post(
      _url + "/bd/comprobarIdNFC.php",
      body: {
        "idNFC": idNFC,
      },
    );
    return _respuestaIdNFC(response);
  }

  @override
  Future<bool> grabarArboleRemoteData({ArbolEntity arbol}) async {
    //OJO: esto solo comprueba que este el id del arbol
    // Campo clientes
    List resultCliente = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.cliente.nombreTabla,
      campoOrdenador: referencia.cliente.clienteNombre,
    );
    String id_entidad_arbol;
    resultCliente.forEach((cliente) {
      if (cliente['clienteNombre'] == arbol.clienteArbol) {
        id_entidad_arbol = cliente['clienteOrigenId'].toString();
      }
    });
    print('El id_entidad_arbol que se envia es: $id_entidad_arbol');

//     Campo zona
    List resultZona = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.zona.nombreTabla,
      campoOrdenador: referencia.zona.zonaOrigenId,
    );
    String id_sector_entidad_arbol;
    resultZona.forEach((zona) {
      if (zona['zonaNombre'] == arbol.zonaArbol) {
        id_sector_entidad_arbol = zona['zonaOrigenId'].toString();
      }
    });
    print(
        'El id_sector_entidad_arbol que se envia es: $id_sector_entidad_arbol');

// Campo calle
    List resultCalle = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.calle.nombreTabla,
      campoOrdenador: referencia.calle.calleOrigenId,
    );

    String id_calle_arbol;
    resultCalle.forEach((calle) {
      if (calle['calleNombre'] == arbol.calleArbol) {
        id_calle_arbol = calle['calleOrigenId'].toString();
      }
    });
    print('el id_calle_arbol que se envia: $id_calle_arbol');

    // Campo n calle
    String n_calle_arbol = arbol.nCalleArbol.toString();
    print('el n_calle_arbol que se envia: $n_calle_arbol');

    // Campo idnFC

    String id_nfc_arbol = arbol.idNfcHistoria.last;
    print('el id_nfc_arbol que se envia: $id_nfc_arbol');

    // Campo GUI
    Uuid gui = Uuid();
    String gui_arbol;
    if (arbol.guiArbol == null) {
      gui_arbol = gui.v1();
    } else {
      gui_arbol = arbol.guiArbol.toString();
    }
    print('el gui_arbol que se envia: $gui_arbol');

    // Campo especie
    List resultEspecie = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.especie.nombreTabla,
      campoOrdenador: referencia.especie.especieOrden,
    );
    String id_especie_arbol;
    resultEspecie.forEach((elemento) {
      if (elemento['especieNombreCientifico'] == arbol.especieArbol) {
        id_especie_arbol = elemento['especieId'].toString();
      }
    });
    print('El id_especie_arbol que se envia es: $id_especie_arbol');

// Campo diametro de tronco
    String id_diametro_tronco = arbol.diametroTroncoArbolCm.toString();
    print('el id_diametro_tronco que se envia: $id_diametro_tronco');

    // Campo diametro de tcopa ns
    String id_diametro_copa_ns_arbol = arbol.diametroCopaNsArbolMt.toString();
    print(
        'el id_diametro_copa_ns_arbol que se envia: $id_diametro_copa_ns_arbol');

    // Campo diametro de tcopa eo
    String id_diametro_copa_eo_arbol = arbol.diametroCopaEoArbolMt.toString();
    print(
        'el id_diametro_copa_eo_arbol que se envia: $id_diametro_copa_eo_arbol');

    // Campo altura Arbol
    String id_altura_arbol = arbol.alturaArbolArbolMt.toString();
    print('el id_altura_arbol que se envia: $id_altura_arbol');

    // Campo altura copa
    String id_altura_copa_arbol = arbol.alturaCopaArbolMt.toString();
    print('el id_altura_copa_arbol que se envia: $id_altura_copa_arbol');

    // Estado general
    List resultEstadoGeneral = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.estadoGeneral.nombreTabla,
      campoOrdenador: referencia.estadoGeneral.estadoGeneralId,
    );
    String id_estado_general_arbol;
    resultEstadoGeneral.forEach((elemento) {
//      print(elemento);
      if (elemento['estadoGeneralDesc'] == arbol.estadoGeneralArbol) {
        id_estado_general_arbol = elemento['estadoGeneralId'].toString();
      }
    });
    print(
        'El id_estado_general_arbol que se envia es: $id_estado_general_arbol');

    // El estado Sanitario
    List resultEstadoSanitario = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.estadoSanitario.nombreTabla,
      campoOrdenador: referencia.estadoSanitario.estadoSanitarioOrigenId,
    );
    String id_estado_sanitario_arbol;
    resultEstadoSanitario.forEach((elemento) {
      if (elemento['estadoSanitarioDesc'] == arbol.estadoSanitarioArbol) {
        id_estado_sanitario_arbol =
            elemento['estadoSanitarioOrigenId'].toString();
      }
    });
    print('El id_estado_sanitario que se envia es: $id_estado_sanitario_arbol');

    // Los agentes patogenos
    List resultAgentesPatogenos = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.agentesPatogenos.nombreTabla,
      campoOrdenador: referencia.agentesPatogenos.agentePatogenoDesc,
    );
    String id_agentes_patogenos;
    resultAgentesPatogenos.forEach((elemento) {
//      print(elemento);
      if (elemento['agentePatogenoDesc'] == arbol.agentePatogeno) {
        id_agentes_patogenos = elemento['agentePatogenoOrigenId'].toString();
      }
    });
    print('El id_agentes_patogenos que se envia es: $id_agentes_patogenos');

    // El sintoma
    List resultSintomas = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.sintomas.nombreTabla,
      campoOrdenador: referencia.sintomas.sintomaDesc,
    );
    String id_sintoma;
    resultSintomas.forEach((elemento) {
      if (elemento['sintomaDesc'] == arbol.sintoma) {
        id_sintoma = elemento['sintomaOrigenId'].toString();
      }
    });
    print('El id_sintoma que se envia es: $id_sintoma');

    // El lugar de la plaga
    List resultLugarPlaga = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.lugarPlaga.nombreTabla,
      campoOrdenador: referencia.lugarPlaga.lugarPlagaDesc,
    );
    String id_lugar_plaga;
    resultLugarPlaga.forEach((elemento) {
//      print(elemento);
      if (elemento['lugarPlagaDesc'] == arbol.lugarPlaga) {
        id_lugar_plaga = elemento['lugarPlagaOrigenId'].toString();
      }
    });
    print('El id_lugar_plaga que se envia es: $id_lugar_plaga');

    // La inclinacion del tronco

    List resultInclinacionTronco = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.inclinacionTronco.nombreTabla,
      campoOrdenador: referencia.inclinacionTronco.inclinacionTroncoId,
    );
    String id_inclinacion_tronco_arbol;
    resultInclinacionTronco.forEach((elemento) {
      if (elemento['inclinacionTroncoDesc'] == arbol.inclinacionTroncoArbol) {
        id_inclinacion_tronco_arbol =
            elemento['inclinacionTroncoOrigenId'].toString();
      }
    });
    print(
        'El id_inclinacion_tronco_arbol que se envia es: $id_inclinacion_tronco_arbol');

    // La orientacion inclinacion

    List resultOrientacionInclinacion = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.orientacionInclinacion.nombreTabla,
      campoOrdenador:
          referencia.orientacionInclinacion.orientacionInclinacionId,
    );
    String id_orientacion_inclinacion_arbol;
    resultOrientacionInclinacion.forEach((elemento) {
      if (elemento['orientacionInclinacionDesc'] ==
          arbol.orientacionInclinacionArbol) {
        id_orientacion_inclinacion_arbol =
            elemento['orientacionInclinacionOrigenId'].toString();
      }
    });
    print(
        'El id_orientacion_inclinacion_arbol que se envia es: $id_orientacion_inclinacion_arbol');

    // La accion Observacion

    List resultAccionObs = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.accionObs.nombreTabla,
      campoOrdenador: referencia.accionObs.accionObsDesc,
    );
    String id_accion_obs_arbol;
    resultAccionObs.forEach((elemento) {
      if (elemento['accionObsDesc'] == arbol.accionObsArbol) {
        id_accion_obs_arbol = elemento['accionObsOrigenId'].toString();
      }
    });
    print('El id_accion_obs_arbol que se envia es: $id_accion_obs_arbol');

    // La  Segunda accion Observacion

    List resultSegundaAccionObs = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.accionObs.nombreTabla,
      campoOrdenador: referencia.accionObs.accionObsDesc,
    );
    String id_accion_obs_arbol_2;
    resultSegundaAccionObs.forEach((elemento) {
      if (elemento['accionObsDesc'] == arbol.accionObsArbol) {
        id_accion_obs_arbol_2 = elemento['accionObsOrigenId'].toString();
      }
    });
    print('El id_accion_obs_arbol_2 que se envia es: $id_accion_obs_arbol_2');

    // La tercera accion Observacion

    List resultTerceraAccionObs = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.accionObs.nombreTabla,
      campoOrdenador: referencia.accionObs.accionObsDesc,
    );
    String id_accion_obs_arbol_3;
    resultTerceraAccionObs.forEach((elemento) {
      if (elemento['accionObsDesc'] == arbol.accionObsArbol) {
        id_accion_obs_arbol_3 = elemento['accionObsOrigenId'].toString();
      }
    });
    print('El id_accion_obs_arbol_3 que se envia es: $id_accion_obs_arbol_3');

    //TODO: implementar en base de datos interna una tabla con todas las obs de los arboles
    // Campo Observaciones Arbol
    String observaciones_arbol = arbol.obsArbolHistoria.last.toString();
    print('el observaciones_arbol que se envia: $observaciones_arbol');

    // Campo Georeferencia por GPS
    String geo_referencia_gps_arbol = null;
    print(
        'el geo_referencia_gps_arbol que se envia: $geo_referencia_gps_arbol');

    // Campo Georeferencia por Captura
    String geo_referencia_captura_arbol = null;
    print(
        'el geo_referencia_captura_arbol que se envia: $geo_referencia_captura_arbol');

    // Campo Georeferencia por Google, unico valido
    String geo_referencia_google_arbol =
        "${arbol.geoReferenciaCapturaArbol.latitude.toString()},${arbol.geoReferenciaCapturaArbol.longitude.toString()}";
    print(
        'el geo_referencia_google_arbol que se envia: $geo_referencia_google_arbol');

    // Alerta Arbol
    String alerta_arbol = arbol.alertaArbol;
    print('el alerta_arbol que se envia: $alerta_arbol');

    // Revision Arbol
    String revision_arbol = arbol.alertaArbol;
    print('el revision_arbol que se envia: $revision_arbol');

    // Campo calle Esquina
    List resultEsquinaCalle = await _databaseHelper.getFilasMapListWhere(
      nombreTabla: referencia.calleEsquina.nombreTabla,
      campoOrdenador: referencia.calleEsquina.calleEsquinaOrigenId,
      campoRestringido: referencia.calleEsquina.calleEsquinaZonaId,
      valorRestrictor: id_sector_entidad_arbol,
    );

    String esquina_calle_arbol;
    resultEsquinaCalle.forEach((esquinaCalle) {
      if (esquinaCalle['calleEsquinaNombre'] == arbol.esquinaCalleArbol) {
        esquina_calle_arbol = esquinaCalle['calleEsquinaNombre'].toString();
      }
    });
    print('el esquina_calle_arbol que se envia: $esquina_calle_arbol');

    //Usuario creacion de arbol

    List resultUsuarioCreacion = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.usuario.nombreTabla,
      campoOrdenador: referencia.usuario.usuarioOrigenId,
    );

    String id_usuario_creacion_arbol;
    resultUsuarioCreacion.forEach((usuario) {
      if ('${usuario['usuarioNombre']} ${usuario['usuarioApellido']}' ==
          arbol.nombreUsuarioCreacionArbol) {
        id_usuario_creacion_arbol = usuario['usuarioRol'].toString();
      }
    });
    print(
        'el id_usuario_creacion_arbol que se envia: $id_usuario_creacion_arbol');

    //Usuario modificacion arbol

    List resultUsuarioModificacion = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.usuario.nombreTabla,
      campoOrdenador: referencia.usuario.usuarioOrigenId,
    );

    String id_usuario_modifica_arbol;
    resultUsuarioModificacion.forEach((usuario) {
      if ('${usuario['usuarioNombre']} ${usuario['usuarioApellido']}' ==
          arbol.usuarioModificaArbol) {
        id_usuario_modifica_arbol = usuario['usuarioRol'].toString();
      }
    });
    print(
        'el id_usuario_modifica_arbol que se envia: $id_usuario_modifica_arbol');

// Fecha de creacion
    String fecha_creacion_arbol = arbol.fechaCreacionArbol.toUtc().toString();
    print('el fecha_creacion_arbol que se envia: $fecha_creacion_arbol');
    // Fecha de modificacion
    String fecha_ultima_mod_arbol =
        arbol.fechaUltimaModArbol.toUtc().toString();
    print('el fecha_creacion_arbol que se envia: $fecha_ultima_mod_arbol');

    /*   final response = await client.post(
      _url + "/bd/comprobarIdNFC.php",
      body: {
        "id_nfc_arbol": arbol.idNfcHistoria.last,
        "gui_arbol": gui_arbol,
        "id_entidad_arbol": id_entidad_arbol,
        "id_sector_entidad_arbol": id_sector_entidad_arbol,
        "id_calle_arbol": id_calle_arbol,
        "n_calle_arbol": arbol.nCalleArbol,

//        "id_especie_arbol":
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }*/
    return true;

    //TODO: escribir el procedimiento para grabar el árbol en PHP 😥
  }

  bool _respuestaIdNFC(http.Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ObjetoLista> llenarObjetoListaDesdeHttp({String tabla}) async {
    final _response = await http.post(
      _url + "/bd/getTablas.php",
      body: {
        "tabla": tabla,
      },
    );
    if (_response.statusCode == 200) {
      final respuestaDecodificada = json.decode(_response.body);
      return funcionSwitch(respuestaDecodificada, tabla);
    } else {
      throw ServerException();
    }
  }

  //OJO: Metodo Listo falta TDD
  @override
  Future<bool> actualizarBaseDatosFormularios() async {
    try {
      await _databaseHelper.borrarBasedatos();
      await _databaseHelper.inicializarDatabase();
      nombreTablasFormBD.forEach((nombreTabla) async {
//        print(nombreTabla);
        await this
            .llenarObjetoListaDesdeHttp(tabla: nombreTabla['nombre'])
            .then((_objetoLista) {
//          print(nombreTabla['nombre']);
          _objetoLista.elementos.forEach((fila) async {
            await _databaseHelper.insertFila(
              objetoFila: fila,
              nombreTabla: nombreTabla['nombre'],
            );
          });
        });
      });
    } catch (e, s) {
      print(s);
    }
    return true;
  }

  ObjetoLista funcionSwitch(response, tabla) {
    switch (tabla) {
      case 'tablaEspecie':
        ListaEspecieModelo objetoTabla = ListaEspecieModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaZona':
        ListaZonaModelo objetoTabla = ListaZonaModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaCalle':
        ListaCalleModelo objetoTabla = ListaCalleModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaCalleEsquina':
        ListaCalleEsquinaModelo objetoTabla =
            ListaCalleEsquinaModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaUsuario':
        ListaUsuarioModelo objetoTabla = ListaUsuarioModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaEstadoGeneral':
        ListaEstadoGeneralModelo objetoTabla =
            ListaEstadoGeneralModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaEstadoSanitario':
        ListaEstadoSanitarioModelo objetoTabla =
            ListaEstadoSanitarioModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaInclinacionTronco':
        ListaInclinacionTroncoModelo objetoTabla =
            ListaInclinacionTroncoModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaOrientacionInclinacion':
        ListaOrientacionInclinacionModelo objetoTabla =
            ListaOrientacionInclinacionModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaAccionObs':
        ListaAccionObsModelo objetoTabla =
            ListaAccionObsModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaCliente':
        ListaClienteModelo objetoTabla = ListaClienteModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaAgentesPatogenos':
        ListaAgentePatogenoModelo objetoTabla =
            ListaAgentePatogenoModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaLugarPlaga':
        ListaLugarPlagaModelo objetoTabla =
            ListaLugarPlagaModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaPlagas':
        ListaPlagaModelo objetoTabla = ListaPlagaModelo.fromJson(response);
        return objetoTabla;
        break;
      case 'tablaSintoma':
        ListaSintomaModelo objetoTabla = ListaSintomaModelo.fromJson(response);
        return objetoTabla;
        break;

      default:
        return null;
    }
  }
}
