import 'dart:convert';
import 'package:flutterapparbol/features/arbol/data/models/user_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

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
      {LatLng coordenadas, int distancia});

  // Solo necesito que la operación se haya realizado correctamente
  //OJO: no terminado
  Future<bool> grabarArboleRemoteData({ArbolEntity arbol});
  //OJO: no terminado
  Future<bool> verificarSiExisteIdNfcRemoteData({String idNFC});
  //OJO: no terminado
  Future<ArbolesEntityModelo> getArbolPorIdNFCRemoteData({String idNFC});
  Future<ObjetoLista> llenarObjetoListaDesdeHttp({String tabla});
  Future<bool> actualizarBaseDatosFormularios();
  Future<bool> updateArbolRemoteData({ArbolEntity arbol});
  Future<UserEntity> loginRemoteData({String password, String rut});
}

@LazySingleton(as: ArbolesRemoteDataSource)
class ArbolesRemoteDataSourceImpl extends ArbolesRemoteDataSource {
  final http.Client client;
  final EsquemaDataDeSQL referencia;

  ArbolesRemoteDataSourceImpl({
    @required this.client,
    @required this.referencia,
  });
//  final EsquemaDataDeSQL referencia = EsquemaDataDeSQL();
  final String _url = urlPruebas;
//  FormLocalSourceSqlImpl _databaseHelper = FormLocalSourceSqlImpl();
  // debo instanciar esta databaseHelper, de lo contrario no me funciona abajo
  FormLocalSourceSqlImpl databaseHelper = FormLocalSourceSqlImpl();
  @override
  Future<ArbolesEntityModelo> getArbolesCercanosRemoteData(
      {LatLng coordenadas, int distancia}) async {
    final response = await http.post(
      _url + "/bd/getArbolPorCoordenadas.php",
      body: {
        "latitud": coordenadas.latitude.toString(),
        "longitud": coordenadas.longitude.toString(),
        "distancia": distancia.toString(),
      },
    );
    //TODO: Trabajar en php para obtener un listado de arboles que pueda meter abajo
//    print('el body de esto es ${response.body}');
    if (response.statusCode == 200) {
      final List<Map> jsonMaped =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      final ArbolesEntityModelo arbolesEntityModelo =
          ArbolesEntityModelo.fromJsonImportServer(
              parsedListMapFromJson: jsonMaped);
      return arbolesEntityModelo;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserEntity> loginRemoteData({String password, String rut}) async {
    final response = await client.post(
      _url + "/bd/loginApp.php",
      body: {
        "rut_usuario": rut,
        "password_usuario": password,
      },
    );
//    print('el body de esto es ${response.body}');
    if (response.statusCode == 200) {
      if (response.body != '[]') {
        final List<Map> jsonMaped =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        if (jsonMaped.toString() != '[]') {
          final UserEntityModel usuario =
              UserEntityModel.fromJson(jsonMaped[0]);
          return usuario;
        } else {
          throw PassException();
        }
      } else {
        throw PassException();
      }
    } else {
      throw ServerException();
    }
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
  Future<bool> verificarSiExisteIdNfcRemoteData({String idNFC}) async {
    final response = await client.post(
      _url + "/bd/comprobarIdNFC.php",
      body: {
        "idNFC": idNFC,
      },
    );
    return _respuestaIdNFC(response);
  }

  @override
  Future<bool> updateArbolRemoteData({ArbolEntity arbol}) async {
    // TODO: implement updateArboleRemoteData
    var uri = Uri.parse(_url + "/bd/updateArbol.php");
    var request = http.MultipartRequest('POST', uri)
      ..fields["id_nfc_arbol"] = arbol.idNfcHistoria.last
      ..fields["gui_arbol"] =
          await buscaValoresIdentificadores(arbol, 'gui_arbol')
      ..fields["id_entidad_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_entidad_arbol')
      ..fields["id_sector_entidad_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_sector_entidad_arbol')
      ..fields["id_calle_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_calle_arbol')
      ..fields["n_calle_arbol"] = arbol.nCalleArbol.toString()
      ..fields["id_especie_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_especie_arbol')
      ..fields["id_diametro_tronco_arbol"] =
          arbol.diametroTroncoArbolCm.toString()
      ..fields["id_diametro_copa_ns_arbol"] =
          arbol.diametroCopaNsArbolMt.toString()
      ..fields["id_diametro_copa_eo_arbol"] =
          arbol.diametroCopaEoArbolMt.toString()
      ..fields["id_altura_arbol_arbol"] = arbol.alturaArbolArbolMt.toString()
      ..fields["id_altura_copa_arbol"] = arbol.alturaCopaArbolMt.toString()
      ..fields["id_estado_general_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_estado_general_arbol')
      ..fields["id_estado_sanitario_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_estado_sanitario_arbol')
      ..fields["id_agentes_patogenos_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_agentes_patogenos_arbol')
      ..fields["id_sintoma_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_sintoma_arbol')
      ..fields["id_lugar_plaga_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_lugar_plaga_arbol')
      ..fields["id_inclinacion_tronco_arbol"] =
          await buscaValoresIdentificadores(
              arbol, 'id_inclinacion_tronco_arbol')
      ..fields["id_orientacion_inclinacion_arbol"] =
          await buscaValoresIdentificadores(
              arbol, 'id_orientacion_inclinacion_arbol')
      ..fields["id_accion_obs_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol')
      ..fields["id_accion_obs_arbol_2"] =
          await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_2')
      ..fields["id_accion_obs_arbol_3"] =
          await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_3')
      ..fields["observaciones_arbol"] = arbol.obsArbolHistoria.last.toString()
      ..fields["geo_referencia_gps_arbol"] = ""
      ..fields["geo_referencia_captura_arbol"] = ""
      ..fields["geo_referencia_google_arbol"] =
          "${arbol.geoReferenciaCapturaArbol.latitude.toString()},${arbol.geoReferenciaCapturaArbol.longitude.toString()}"
      ..fields["alerta_arbol"] = arbol.alertaArbol
      ..fields["revision_arbol"] = arbol.revisionArbol
      ..fields["esquina_calle_arbol"] =
          await buscaValoresIdentificadores(arbol, 'esquina_calle_arbol')
      ..fields["id_usuario_creacion_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_usuario_creacion_arbol')
      ..fields["id_usuario_modifica_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_usuario_modifica_arbol')
      ..fields["fecha_creacion_arbol"] =
          arbol.fechaCreacionArbol.toLocal().toString()
      ..fields["fecha_ultima_mod_arbol"] =
          arbol.fechaUltimaModArbol.toLocal().toString();
    for (String pathFoto in arbol.fotosArbol) {
      request.files.add(await http.MultipartFile.fromPath(
          'fotografia_arbol_${arbol.fotosArbol.indexOf(pathFoto) + 1}',
          pathFoto.toString()));
      print('fotografia_arbol_${arbol.fotosArbol.indexOf(pathFoto) + 1}');
    }
    for (String pathFoto in arbol.fotosEnfermedad) {
      request.files.add(await http.MultipartFile.fromPath(
          'fotografia_arbol_sanitario_${arbol.fotosEnfermedad.indexOf(pathFoto) + 1}',
          pathFoto.toString()));
      print(
          'fotografia_arbol_sanitario_${arbol.fotosEnfermedad.indexOf(pathFoto) + 1}');
    }
    print('asignadas variables a update');

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Arbol Enviado con Exito a Servidor');
        return true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(
          'Remote Data Source llamada a servidor, hay un error en el requeset: $e');
      return null;
    }
  }

  @override
  Future<bool> grabarArboleRemoteData({ArbolEntity arbol}) async {
    print('remote data source GrabarArbolesRemoteData:  apretado el boton');

    //TODO: implementar en base de datos interna una tabla con todas las obs de los arboles

    var uri = Uri.parse(_url + "/bd/insertArbol.php");
    var request = http.MultipartRequest('POST', uri)
      ..fields["id_nfc_arbol"] = arbol.idNfcHistoria.last
      ..fields["gui_arbol"] =
          await buscaValoresIdentificadores(arbol, 'gui_arbol')
      ..fields["id_entidad_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_entidad_arbol')
      ..fields["id_sector_entidad_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_sector_entidad_arbol')
      ..fields["id_calle_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_calle_arbol')
      ..fields["n_calle_arbol"] = arbol.nCalleArbol.toString()
      ..fields["id_especie_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_especie_arbol')
      ..fields["id_diametro_tronco_arbol"] =
          arbol.diametroTroncoArbolCm.toString()
      ..fields["id_diametro_copa_ns_arbol"] =
          arbol.diametroCopaNsArbolMt.toString()
      ..fields["id_diametro_copa_eo_arbol"] =
          arbol.diametroCopaEoArbolMt.toString()
      ..fields["id_altura_arbol_arbol"] = arbol.alturaArbolArbolMt.toString()
      ..fields["id_altura_copa_arbol"] = arbol.alturaCopaArbolMt.toString()
      ..fields["id_estado_general_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_estado_general_arbol')
      ..fields["id_estado_sanitario_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_estado_sanitario_arbol')
      ..fields["id_agentes_patogenos_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_agentes_patogenos_arbol')
      ..fields["id_sintoma_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_sintoma_arbol')
      ..fields["id_lugar_plaga_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_lugar_plaga_arbol')
      ..fields["id_inclinacion_tronco_arbol"] =
          await buscaValoresIdentificadores(
              arbol, 'id_inclinacion_tronco_arbol')
      ..fields["id_orientacion_inclinacion_arbol"] =
          await buscaValoresIdentificadores(
              arbol, 'id_orientacion_inclinacion_arbol')
      ..fields["id_accion_obs_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol')
      ..fields["id_accion_obs_arbol_2"] =
          await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_2')
      ..fields["id_accion_obs_arbol_3"] =
          await buscaValoresIdentificadores(arbol, 'id_accion_obs_arbol_3')
      ..fields["observaciones_arbol"] = arbol.obsArbolHistoria.last.toString()
      ..fields["geo_referencia_gps_arbol"] = ""
      ..fields["geo_referencia_captura_arbol"] = ""
      ..fields["geo_referencia_google_arbol"] =
          "${arbol.geoReferenciaCapturaArbol.latitude.toString()},${arbol.geoReferenciaCapturaArbol.longitude.toString()}"
      ..fields["alerta_arbol"] = arbol.alertaArbol
      ..fields["revision_arbol"] = arbol.revisionArbol
      ..fields["esquina_calle_arbol"] =
          await buscaValoresIdentificadores(arbol, 'esquina_calle_arbol')
      ..fields["id_usuario_creacion_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_usuario_creacion_arbol')
      ..fields["id_usuario_modifica_arbol"] =
          await buscaValoresIdentificadores(arbol, 'id_usuario_modifica_arbol')
      ..fields["fecha_creacion_arbol"] =
          arbol.fechaCreacionArbol.toLocal().toString()
      ..fields["fecha_ultima_mod_arbol"] =
          arbol.fechaUltimaModArbol.toLocal().toString()
      ..fields["id_arbol"] = arbol.idArbol.toString();

    for (String pathFoto in arbol.fotosArbol) {
      request.files.add(await http.MultipartFile.fromPath(
          'fotografia_arbol_${arbol.fotosArbol.indexOf(pathFoto) + 1}',
          pathFoto.toString()));
      print('fotografia_arbol_${arbol.fotosArbol.indexOf(pathFoto) + 1}');
    }
    for (String pathFoto in arbol.fotosEnfermedad) {
      request.files.add(await http.MultipartFile.fromPath(
          'fotografia_arbol_sanitario_${arbol.fotosEnfermedad.indexOf(pathFoto) + 1}',
          pathFoto.toString()));
      print(
          'fotografia_arbol_sanitario_${arbol.fotosEnfermedad.indexOf(pathFoto) + 1}');
    }
    print(
        'remote data source GrabarArbolesRemoteData: asignadas variables a insert');
    print(request.fields);
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(
          'Remote Data Source llamada a servidor, hay un error en el requeset: $e');
      return null;
    }
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
      await databaseHelper.borrarBasedatos();
      await databaseHelper.inicializarDatabase();

      nombreTablasFormBD.forEach((nombreTabla) async {
        await this
            .llenarObjetoListaDesdeHttp(tabla: nombreTabla['nombre'])
            .then((_objetoLista) {
          _objetoLista.elementos.forEach((fila) async {
            await databaseHelper.insertFila(
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
        List resultCliente = await databaseHelper.getFilasMapList(
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
        List resultZona = await databaseHelper.getFilasMapList(
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
        List resultCalle = await databaseHelper.getFilasMapList(
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
        List resultEspecie = await databaseHelper.getFilasMapList(
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
        List resultEstadoGeneral = await databaseHelper.getFilasMapList(
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
        List resultEstadoSanitario = await databaseHelper.getFilasMapList(
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

      case 'id_agentes_patogenos_arbol':
        List resultAgentesPatogenos = await databaseHelper.getFilasMapList(
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

      case 'id_sintoma_arbol':
        List resultSintomas = await databaseHelper.getFilasMapList(
          nombreTabla: referencia.sintomas.nombreTabla,
          campoOrdenador: referencia.sintomas.sintomaDesc,
        );
        String id_sintoma_arbol;
        resultSintomas.forEach((elemento) {
          if (elemento['sintomaDesc'] == _arbol.enfermedad.sintoma) {
            id_sintoma_arbol = elemento['sintomaOrigenId'].toString();
          }
        });
        return id_sintoma_arbol;
        break;

      case 'id_lugar_plaga_arbol':
        List resultLugarPlaga = await databaseHelper.getFilasMapList(
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
        List resultInclinacionTronco = await databaseHelper.getFilasMapList(
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
            await databaseHelper.getFilasMapList(
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
        List resultAccionObs = await databaseHelper.getFilasMapList(
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
        List resultSegundaAccionObs = await databaseHelper.getFilasMapList(
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
        List resultTerceraAccionObs = await databaseHelper.getFilasMapList(
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
        List resultZona = await databaseHelper.getFilasMapList(
          nombreTabla: referencia.zona.nombreTabla,
          campoOrdenador: referencia.zona.zonaOrigenId,
        );
        String id_sector_entidad_arbol;
        resultZona.forEach((zona) {
          if (zona['zonaNombre'] == _arbol.zonaArbol) {
            id_sector_entidad_arbol = zona['zonaOrigenId'].toString();
          }
        });
        List resultEsquinaCalle = await databaseHelper.getFilasMapListWhere(
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
        List resultUsuarioCreacion = await databaseHelper.getFilasMapList(
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
        List resultUsuarioModificacion = await databaseHelper.getFilasMapList(
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

  Future<File> choiceImage(ImagePicker picker) async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    print('la imagen esta en : ${pickedImage.path}');
    return File(pickedImage.path);
  }
}

// TEST
/*  print('id_nfc_arbol: ${arbol.idNfcHistoria.last} ');
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
    print('id_altura_arbol_arbol: ${arbol.alturaArbolArbolMt.toString()}');
    print('id_altura_copa_arbol: ${arbol.alturaCopaArbolMt.toString()}');
    print(
        'id_estado_general_arbol: ${await buscaValoresIdentificadores(arbol, 'id_estado_general_arbol')}');
    print(
        'id_estado_sanitario_arbol: ${await buscaValoresIdentificadores(arbol, 'id_estado_sanitario_arbol')}');
    print(
        'id_agentes_patogenos_arbol: ${await buscaValoresIdentificadores(arbol, 'id_agentes_patogenos_arbol')}');
    print(
        'id_sintoma_arbol: ${await buscaValoresIdentificadores(arbol, 'id_sintoma_arbol')}');
    print(
        'id_lugar_plaga_arbol: ${await buscaValoresIdentificadores(arbol, 'id_lugar_plaga_arbol')}');
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
    print('observaciones_arbol : ${arbol.obsArbolHistoria.last.toString()}');
    print('geo_referencia_gps_arbol: ""');
    print('geo_referencia_captura_arbol: ""');
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
        'fecha_creacion_arbol: ${await arbol.fechaCreacionArbol.toLocal().toString()}');
    print(
        'fecha_ultima_mod_arbol: ${arbol.fechaUltimaModArbol.toLocal().toString()}');*/
