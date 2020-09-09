import 'dart:convert';

import 'package:flutterapparbol/core/constants/server_prueba.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class ArbolesRemoteDataSource {
  /// Va al sector de pruebas y ejecuta un archivo mediante un método post
  ///   http://35.224.182.198 y si funciona obtiene [ArbolesEntityModelo] si no
  ///  Arroja una excepcion [ServiceException] para todos los errores
  ///  Finalmente en implementación debería ir a  http://35.225.91.186
  Future<ArbolesEntityModelo> getArbolesCercanosRemoteData(
      {LatLng coordenadas});

  // Esto esta mal porque no se necesita devolver una entidad de ListaDeArboles
  // Solo necesito que la operación se haya realizado correctamente
  Future<bool> grabarArbolesRemoteData({ArbolEntity arbol});
  Future<bool> verificarIdNFCRemoteData({String idNFC});
  Future<ArbolesEntityModelo> getArbolPorIdNFCRemoteData({String idNFC});
  Future<FormEntityModelo> getDatosForm({String idUsuario});
  Future<ObjetoFila> llenarObjetoListaDesdeHttp({String tabla});
}

class ArbolesRemoteDataSourceImpl extends ArbolesRemoteDataSource {
  final http.Client client;
  ArbolesRemoteDataSourceImpl({@required this.client});
  final String _url = urlPruebas;

  @override
  Future<FormEntityModelo> getDatosForm({String idUsuario}) async {
    // TODO: implement getDatosForm
    throw UnimplementedError();
  }

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
    final _response = await client.post(
      _url + "/bd/comprobarIdNFC.php",
      body: {
        "idNFC": idNFC,
      },
    );
    return _respuestaIdNFC(_response);
  }

  @override
  Future<bool> grabarArbolesRemoteData({ArbolEntity arbol}) async {
    //OJO: esto solo comprueba que este el id del arbol
    final _response = await client.post(
      _url + "/bd/comprobarIdNFC.php",
      body: {
        "idNFC": arbol.guiArbol,
      },
    );
    if (_response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
    //TODO: escribir el procedimiento para grabar el árbol 😥
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
  Future<ObjetoFila> llenarObjetoListaDesdeHttp({String tabla}) async {
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

//TODO: completar todos los casos
  ObjetoFila funcionSwitch(response, tabla) {
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
