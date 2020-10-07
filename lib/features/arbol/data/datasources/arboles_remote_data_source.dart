import 'dart:convert';
import 'package:uuid/uuid.dart';

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
  //OJO: no terminado
  Future<ArbolesEntityModelo> getArbolesCercanosRemoteData(
      {LatLng coordenadas});

  // Esto esta mal porque no se necesita devolver una entidad de ListaDeArboles
  // Solo necesito que la operación se haya realizado correctamente
  //OJO: no terminado
  Future<bool> grabarArboleRemoteData({ArbolEntity arbol});
  //OJO: no terminado
  Future<bool> verificarIdNFCRemoteData({String idNFC});
  //OJO: no terminado
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
    //TODO: implementar en base de datos interna una tabla con todas las obs de los arboles
// TEST
    /* print('id_nfc_arbol: ${arbol.idNfcHistoria.last} ');
    print(
        'gui_arbol: ${await buscaValoresIdentificadores(arbol, 'gui_arbol')}');
    print(
        'id_entidad_arbol: ${await buscaValoresIdentificadores(arbol, 'id_entidad_arbol')} ');
    print(
        'id_sector_entidad_arbol: ${await buscaValoresIdentificadores(arbol, 'id_sector_entidad_arbol')}');
    print(
        'id_calle_arbol: ${await buscaValoresIdentificadores(arbol, 'id_calle_arbol')}');
    print('n_calle_arbol: ${arbol.nCalleArbol.toString()}');
    print(
        'id_especie_arbol: ${await buscaValoresIdentificadores(arbol, 'id_especie_arbol')}');
    print('id_diametro_tronco: ${arbol.diametroTroncoArbolCm.toString()}');
    print(
        'id_diametro_copa_ns_arbol: ${arbol.diametroCopaNsArbolMt.toString()}');
    print(
        'id_diametro_copa_eo_arbol: ${arbol.diametroCopaEoArbolMt.toString()}');
    print('id_altura_arbol: ${arbol.alturaArbolArbolMt.toString()}');
    print('id_altura_copa_arbol: ${arbol.alturaCopaArbolMt.toString()}');
    print(
        'id_estado_general_arbol: ${await buscaValoresIdentificadores(arbol, 'id_estado_general_arbol')}');
    print(
        'id_estado_sanitario_arbol: ${await buscaValoresIdentificadores(arbol, 'id_estado_sanitario_arbol')}');
    print(
        'id_agentes_patogenos: ${await buscaValoresIdentificadores(arbol, 'id_agentes_patogenos')}');
    print(
        'id_sintoma: ${await buscaValoresIdentificadores(arbol, 'id_sintoma')}');
    print(
        'id_lugar_plaga: ${await buscaValoresIdentificadores(arbol, 'id_lugar_plaga')}');
    print(
        'id_inclinacion_tronco_arbol: ${await buscaValoresIdentificadores(arbol, 'id_inclinacion_tronco_arbol')}');
    print(
        'id_orientacion_inclinacion_arbol: ${await buscaValoresIdentificadores(arbol, 'id_orientacion_inclinacion_arbol')}');
    print(
        '"id_accion_obs_arbol": ${await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol')}');
    print(
        'id_accion_obs_arbol_2: ${await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_2')}');
    print(
        'id_accion_obs_arbol_3: ${await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_3')}');
    print('observaciones_arbol ${arbol.obsArbolHistoria.last.toString()}');
    print('geo_referencia_gps_arbol: null');
    print('geo_referencia_captura_arbol: null');
    print(
        'geo_referencia_google_arbol: ${arbol.geoReferenciaCapturaArbol.latitude.toString()},${arbol.geoReferenciaCapturaArbol.longitude.toString()}');
    print('alerta_arbol: ${arbol.alertaArbol}');
    print('revision_arbol: ${arbol.revisionArbol}');
    print(
        'esquina_calle_arbol: ${await buscaValoresIdentificadores(arbol, 'esquina_calle_arbol')}');
    print(
        'id_usuario_creacion_arbol: ${await buscaValoresIdentificadores(arbol, 'id_usuario_creacion_arbol')}');
    print(
        '"id_usuario_modifica_arbol": ${await buscaValoresIdentificadores(arbol, 'id_usuario_modifica_arbol')}');
    print(
        'fecha_creacion_arbol: ${await arbol.fechaCreacionArbol.toUtc().toString()}');
    print(
        'fecha_ultima_mod_arbol: ${arbol.fechaUltimaModArbol.toUtc().toString()}');
*/

    final response = await client.post(
      _url + "/bd/comprobarIdNFC.php",
      body: {
        "id_nfc_arbol": arbol.idNfcHistoria.last,
        "gui_arbol": await buscaValoresIdentificadores(arbol, 'gui_arbol'),
        "id_entidad_arbol":
            await buscaValoresIdentificadores(arbol, 'id_entidad_arbol'),
        "id_sector_entidad_arbol":
            await buscaValoresIdentificadores(arbol, 'id_sector_entidad_arbol'),
        "id_calle_arbol":
            await buscaValoresIdentificadores(arbol, 'id_calle_arbol'),
        "n_calle_arbol": arbol.nCalleArbol.toString(),
        "id_especie_arbol":
            await buscaValoresIdentificadores(arbol, 'id_especie_arbol'),
        "id_diametro_tronco": arbol.diametroTroncoArbolCm.toString(),
        "id_diametro_copa_ns_arbol": arbol.diametroCopaNsArbolMt.toString(),
        "id_diametro_copa_eo_arbol": arbol.diametroCopaEoArbolMt.toString(),
        "id_altura_arbol": arbol.alturaArbolArbolMt.toString(),
        "id_altura_copa_arbol": arbol.alturaCopaArbolMt.toString(),
        "id_estado_general_arbol":
            await buscaValoresIdentificadores(arbol, 'id_estado_general_arbol'),
        "id_estado_sanitario_arbol": await buscaValoresIdentificadores(
            arbol, 'id_estado_sanitario_arbol'),
        "id_agentes_patogenos":
            await buscaValoresIdentificadores(arbol, 'id_agentes_patogenos'),
        "id_sintoma": await buscaValoresIdentificadores(arbol, 'id_sintoma'),
        "id_lugar_plaga":
            await buscaValoresIdentificadores(arbol, 'id_lugar_plaga'),
        "id_inclinacion_tronco_arbol": await buscaValoresIdentificadores(
            arbol, 'id_inclinacion_tronco_arbol'),
        "id_orientacion_inclinacion_arbol": await buscaValoresIdentificadores(
            arbol, 'id_orientacion_inclinacion_arbol'),
        "id_accion_obs_arbol":
            await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol'),
        "id_accion_obs_arbol_2":
            await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_2'),
        "id_accion_obs_arbol_3":
            await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_3'),
        "observaciones_arbol": arbol.obsArbolHistoria.last.toString(),
        "geo_referencia_gps_arbol": null,
        "geo_referencia_captura_arbol": null,
        "geo_referencia_google_arbol":
            "${arbol.geoReferenciaCapturaArbol.latitude.toString()},${arbol.geoReferenciaCapturaArbol.longitude.toString()}",
        "alerta_arbol": arbol.alertaArbol,
        "revision_arbol": arbol.revisionArbol,
        "esquina_calle_arbol":
            await buscaValoresIdentificadores(arbol, 'esquina_calle_arbol'),
        "id_usuario_creacion_arbol": await buscaValoresIdentificadores(
            arbol, 'id_usuario_creacion_arbol'),
        "id_usuario_modifica_arbol": await buscaValoresIdentificadores(
            arbol, 'id_usuario_modifica_arbol'),
        "fecha_creacion_arbol": arbol.fechaCreacionArbol.toUtc().toString(),
        "fecha_ultima_mod_arbol": arbol.fechaUltimaModArbol.toUtc().toString(),
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }

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

  Future<String> buscaValoresIdentificadores(
      ArbolEntity _arbol, String campo) async {
    switch (campo) {
      case 'id_entidad_arbol':
        List resultCliente = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.cliente.nombreTabla,
          campoOrdenador: referencia.cliente.clienteNombre,
        );
        String id_entidad_arbol;
        resultCliente.forEach((cliente) {
          if (cliente['clienteNombre'] == _arbol.clienteArbol) {
            id_entidad_arbol = cliente['clienteOrigenId'].toString();
          }
        });
        return id_entidad_arbol;
        break;

      case 'id_sector_entidad_arbol':
        List resultZona = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.zona.nombreTabla,
          campoOrdenador: referencia.zona.zonaOrigenId,
        );
        String id_sector_entidad_arbol;
        resultZona.forEach((zona) {
          if (zona['zonaNombre'] == _arbol.zonaArbol) {
            id_sector_entidad_arbol = zona['zonaOrigenId'].toString();
          }
        });
        return id_sector_entidad_arbol;
        break;

      case 'id_calle_arbol':
        List resultCalle = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.calle.nombreTabla,
          campoOrdenador: referencia.calle.calleOrigenId,
        );
        String id_calle_arbol;
        resultCalle.forEach((calle) {
          if (calle['calleNombre'] == _arbol.calleArbol) {
            id_calle_arbol = calle['calleOrigenId'].toString();
          }
        });
        return id_calle_arbol;
        break;

      case 'gui_arbol':
        Uuid gui = Uuid();
        String gui_arbol;
        if (_arbol.guiArbol == null) {
          gui_arbol = gui.v1();
        } else {
          gui_arbol = _arbol.guiArbol.toString();
        }
        return gui_arbol;
        break;

      case 'id_especie_arbol':
        List resultEspecie = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.especie.nombreTabla,
          campoOrdenador: referencia.especie.especieOrden,
        );
        String id_especie_arbol;
        resultEspecie.forEach((elemento) {
          if (elemento['especieNombreCientifico'] == _arbol.especieArbol) {
            id_especie_arbol = elemento['especieId'].toString();
          }
        });
        return id_especie_arbol;
        break;

      case 'id_estado_general_arbol':
        List resultEstadoGeneral = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.estadoGeneral.nombreTabla,
          campoOrdenador: referencia.estadoGeneral.estadoGeneralId,
        );
        String id_estado_general_arbol;
        resultEstadoGeneral.forEach((elemento) {
          if (elemento['estadoGeneralDesc'] == _arbol.estadoGeneralArbol) {
            id_estado_general_arbol = elemento['estadoGeneralId'].toString();
          }
        });
        return id_estado_general_arbol;
        break;

      case 'id_estado_sanitario_arbol':
        List resultEstadoSanitario = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.estadoSanitario.nombreTabla,
          campoOrdenador: referencia.estadoSanitario.estadoSanitarioOrigenId,
        );
        String id_estado_sanitario_arbol;
        resultEstadoSanitario.forEach((elemento) {
          if (elemento['estadoSanitarioDesc'] == _arbol.estadoSanitarioArbol) {
            id_estado_sanitario_arbol =
                elemento['estadoSanitarioOrigenId'].toString();
          }
        });
        return id_estado_sanitario_arbol;
        break;

      case 'id_agentes_patogenos':
        List resultAgentesPatogenos = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.agentesPatogenos.nombreTabla,
          campoOrdenador: referencia.agentesPatogenos.agentePatogenoDesc,
        );
        String id_agentes_patogenos;
        resultAgentesPatogenos.forEach((elemento) {
          if (elemento['agentePatogenoDesc'] ==
              _arbol.enfermedad.agentePatogeno) {
            id_agentes_patogenos =
                elemento['agentePatogenoOrigenId'].toString();
          }
        });
        return id_agentes_patogenos;
        break;

      case 'id_sintoma':
        List resultSintomas = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.sintomas.nombreTabla,
          campoOrdenador: referencia.sintomas.sintomaDesc,
        );
        String id_sintoma;
        resultSintomas.forEach((elemento) {
          if (elemento['sintomaDesc'] == _arbol.enfermedad.sintoma) {
            id_sintoma = elemento['sintomaOrigenId'].toString();
          }
        });
        return id_sintoma;
        break;

      case 'id_lugar_plaga':
        List resultLugarPlaga = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.lugarPlaga.nombreTabla,
          campoOrdenador: referencia.lugarPlaga.lugarPlagaDesc,
        );
        String id_lugar_plaga;
        resultLugarPlaga.forEach((elemento) {
          if (elemento['lugarPlagaDesc'] == _arbol.enfermedad.lugarPlaga) {
            id_lugar_plaga = elemento['lugarPlagaOrigenId'].toString();
          }
        });
        return id_lugar_plaga;
        break;

      case 'id_inclinacion_tronco_arbol':
        List resultInclinacionTronco = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.inclinacionTronco.nombreTabla,
          campoOrdenador: referencia.inclinacionTronco.inclinacionTroncoId,
        );
        String id_inclinacion_tronco_arbol;
        resultInclinacionTronco.forEach((elemento) {
          if (elemento['inclinacionTroncoDesc'] ==
              _arbol.inclinacionTroncoArbol) {
            id_inclinacion_tronco_arbol =
                elemento['inclinacionTroncoOrigenId'].toString();
          }
        });
        return id_inclinacion_tronco_arbol;
        break;

      case 'id_orientacion_inclinacion_arbol':
        List resultOrientacionInclinacion =
            await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.orientacionInclinacion.nombreTabla,
          campoOrdenador:
              referencia.orientacionInclinacion.orientacionInclinacionId,
        );
        String id_orientacion_inclinacion_arbol;
        resultOrientacionInclinacion.forEach((elemento) {
          if (elemento['orientacionInclinacionDesc'] ==
              _arbol.orientacionInclinacionArbol) {
            id_orientacion_inclinacion_arbol =
                elemento['orientacionInclinacionOrigenId'].toString();
          }
        });
        return id_orientacion_inclinacion_arbol;
        break;

      case 'id_accion_obs_arbol':
        List resultAccionObs = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.accionObs.nombreTabla,
          campoOrdenador: referencia.accionObs.accionObsDesc,
        );
        String id_accion_obs_arbol;
        resultAccionObs.forEach((elemento) {
          if (elemento['accionObsDesc'] == _arbol.accionObsArbol) {
            id_accion_obs_arbol = elemento['accionObsOrigenId'].toString();
          }
        });
        return id_accion_obs_arbol;
        break;

      case 'id_accion_obs_arbol_2':
        List resultSegundaAccionObs = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.accionObs.nombreTabla,
          campoOrdenador: referencia.accionObs.accionObsDesc,
        );
        String id_accion_obs_arbol_2;
        resultSegundaAccionObs.forEach((elemento) {
          if (elemento['accionObsDesc'] == _arbol.accionObsArbol) {
            id_accion_obs_arbol_2 = elemento['accionObsOrigenId'].toString();
          }
        });
        return id_accion_obs_arbol_2;
        break;

      case 'id_accion_obs_arbol_3':
        List resultTerceraAccionObs = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.accionObs.nombreTabla,
          campoOrdenador: referencia.accionObs.accionObsDesc,
        );
        String id_accion_obs_arbol_3;
        resultTerceraAccionObs.forEach((elemento) {
          if (elemento['accionObsDesc'] == _arbol.accionObsArbol) {
            id_accion_obs_arbol_3 = elemento['accionObsOrigenId'].toString();
          }
        });
        return id_accion_obs_arbol_3;
        break;

      case 'esquina_calle_arbol':
        List resultZona = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.zona.nombreTabla,
          campoOrdenador: referencia.zona.zonaOrigenId,
        );
        String id_sector_entidad_arbol;
        resultZona.forEach((zona) {
          if (zona['zonaNombre'] == _arbol.zonaArbol) {
            id_sector_entidad_arbol = zona['zonaOrigenId'].toString();
          }
        });
        List resultEsquinaCalle = await _databaseHelper.getFilasMapListWhere(
          nombreTabla: referencia.calleEsquina.nombreTabla,
          campoOrdenador: referencia.calleEsquina.calleEsquinaOrigenId,
          campoRestringido: referencia.calleEsquina.calleEsquinaZonaId,
          valorRestrictor: id_sector_entidad_arbol,
        );

        String esquina_calle_arbol;
        resultEsquinaCalle.forEach((esquinaCalle) {
          if (esquinaCalle['calleEsquinaNombre'] == _arbol.esquinaCalleArbol) {
            esquina_calle_arbol = esquinaCalle['calleEsquinaNombre'].toString();
          }
        });
        return esquina_calle_arbol;
        break;

      case 'id_usuario_creacion_arbol':
        List resultUsuarioCreacion = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.usuario.nombreTabla,
          campoOrdenador: referencia.usuario.usuarioOrigenId,
        );

        String id_usuario_creacion_arbol;
        resultUsuarioCreacion.forEach((usuario) {
          if ('${usuario['usuarioNombre']} ${usuario['usuarioApellido']}' ==
              _arbol.nombreUsuarioCreacionArbol) {
            id_usuario_creacion_arbol = usuario['usuarioRol'].toString();
          }
        });
        return id_usuario_creacion_arbol;
        break;

      case 'id_usuario_modifica_arbol':
        List resultUsuarioModificacion = await _databaseHelper.getFilasMapList(
          nombreTabla: referencia.usuario.nombreTabla,
          campoOrdenador: referencia.usuario.usuarioOrigenId,
        );

        String id_usuario_modifica_arbol;
        resultUsuarioModificacion.forEach((usuario) {
          if ('${usuario['usuarioNombre']} ${usuario['usuarioApellido']}' ==
              _arbol.usuarioModificaArbol) {
            id_usuario_modifica_arbol = usuario['usuarioRol'].toString();
          }
        });
        return id_usuario_modifica_arbol;
        break;

      default:
        return null;
    }
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
