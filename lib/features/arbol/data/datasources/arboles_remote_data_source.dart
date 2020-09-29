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
    print('el id_calle_arbol que se envia: $n_calle_arbol');
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
    String id_altura_copa = arbol.alturaCopaArbolMt.toString();
    print('el id_altura_copa que se envia: $id_altura_copa');

    // Estado general
    List resultEstadoGeneral = await _databaseHelper.getFilasMapList(
      nombreTabla: referencia.estadoGeneral.nombreTabla,
      campoOrdenador: referencia.estadoGeneral.estadoGeneralId,
    );
    String id_estado_general;
    resultEstadoGeneral.forEach((elemento) {
      print(elemento);
      if (elemento['estadoGeneralDesc'] == arbol.estadoGeneralArbol) {
        id_estado_general = elemento['estadoGeneralId'].toString();
      }
    });
    print('El id_estado_general que se envia es: $id_estado_general');

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
        await this
            .llenarObjetoListaDesdeHttp(tabla: nombreTabla['nombre'])
            .then((_objetoLista) {
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

      default:
        return null;
    }
  }
}
