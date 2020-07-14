import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class Arbol extends Equatable {
  final String guiArbol;
  final int idArbol;
  final Marker markerArbol;
  final List<String> idNfcHistoria;
  final String clienteArbol;
  final String zonaArbol;
  final String calleArbol;
  final int nCalleArbol;
  final String esquinaCalleArbol;
  final String especieArbol;
  final int diametroTroncoArbolCm;
  final double diametroCopaNsArbolMt;
  final double diametroCopaEoArbolMt;
  final double alturaArbolArbolMt;
  final double alturaCopaArbolMt;
  final String estadoGeneralArbol;
  final String estadoSanitarioArbol;
  final String inclinacionTroncoArbol;
  final String orientacionInclinacionArbol;
  final List<String> obsArbolHisto;
  final String accionObsArbol;
  final LatLng geoReferenciaCapturaArbol;

  final String nombreUsuarioCreacionArbol;
  final String usuarioModificaArbol;
  final DateTime fechaCreacionArbol;
  final DateTime fechaUltimaModArbol;
  final String alertaArbol;
  final String revisionArbol;

  Arbol(
      {@required this.guiArbol,
      @required this.idArbol,
      @required this.markerArbol,
      @required this.idNfcHistoria,
      @required this.clienteArbol,
      @required this.zonaArbol,
      @required this.calleArbol,
      @required this.nCalleArbol,
      @required this.esquinaCalleArbol,
      @required this.especieArbol,
      @required this.diametroTroncoArbolCm,
      @required this.diametroCopaNsArbolMt,
      @required this.diametroCopaEoArbolMt,
      @required this.alturaArbolArbolMt,
      @required this.alturaCopaArbolMt,
      @required this.estadoGeneralArbol,
      @required this.estadoSanitarioArbol,
      @required this.inclinacionTroncoArbol,
      @required this.orientacionInclinacionArbol,
      @required this.obsArbolHisto,
      @required this.accionObsArbol,
      @required this.geoReferenciaCapturaArbol,
      @required this.nombreUsuarioCreacionArbol,
      @required this.usuarioModificaArbol,
      @required this.fechaCreacionArbol,
      @required this.fechaUltimaModArbol,
      @required this.alertaArbol,
      @required this.revisionArbol})
      : super([
          guiArbol,
          idArbol,
          markerArbol,
          idNfcHistoria,
          clienteArbol,
          zonaArbol,
          calleArbol,
          nCalleArbol,
          esquinaCalleArbol,
          especieArbol,
          diametroTroncoArbolCm,
          diametroCopaNsArbolMt,
          diametroCopaEoArbolMt,
          alturaArbolArbolMt,
          alturaCopaArbolMt,
          estadoGeneralArbol,
          estadoSanitarioArbol,
          inclinacionTroncoArbol,
          orientacionInclinacionArbol,
          obsArbolHisto,
          accionObsArbol,
          geoReferenciaCapturaArbol,
          nombreUsuarioCreacionArbol,
          usuarioModificaArbol,
          fechaCreacionArbol,
          fechaUltimaModArbol,
          alertaArbol,
          revisionArbol
        ]);
  factory Arbol.fromJson(Map<String, dynamic> json) {
    return Arbol(
      guiArbol: json["guiArbol"],
      idArbol: int.parse(json["idArbol"]),
      /* markerArbol: json["markerArbol"] != null
          ? Marker(
              markerId: json["idArbol"],
              position: LatLng(double.parse(json["markerArbol"].split(',')[0]),
                  double.parse(json["markerArbol"].split(',')[1])))
          : Marker(markerId: json["id_arbol"], position: LatLng(0, 0)),*/
      idNfcHistoria: json["nfcHistoria"],
      clienteArbol: json["clienteArbol"],
      zonaArbol: json["zonaArbol"],
      calleArbol: json["calleArbol"],
      nCalleArbol: int.parse(json["nCalleArbol"]) != null
          ? int.parse(json["nCalleArbol"])
          : 0,
      esquinaCalleArbol: json["esquinaCalleArbol"] != null
          ? json["esquinaCalleArbol"]
          : 'No es arbol esquina contraria',
      especieArbol: json["especieArbol"],
      diametroTroncoArbolCm: int.parse(json["diametroTroncoArbolCm"]),
      diametroCopaNsArbolMt: double.parse(json["diametroCopaNsArbolMt"]),
      diametroCopaEoArbolMt: double.parse(json["diametroCopaEoArbolMt"]),
      alturaArbolArbolMt: double.parse(json["alturaArbolArbolMt"]),
      alturaCopaArbolMt: double.parse(json["alturaCopaArbolMt"]),
      estadoGeneralArbol: json["estadoGeneralArbol"],
      estadoSanitarioArbol: json["estadoSanitarioArbol"],
      inclinacionTroncoArbol: json["inclinacionTroncoArbol"],
      orientacionInclinacionArbol: json["orientacionInclinacionArbol"],
      obsArbolHisto: json["obsArbolHisto"], // tabla: observaciones_arbol
      accionObsArbol: json["accionObsArbol"],
      geoReferenciaCapturaArbol: json["geoReferenciaCapturaArbol"] != null
          ? LatLng(
              double.parse(json["geoReferenciaCapturaArbol"].split(',')[0]),
              double.parse(json["geoReferenciaCapturaArbol"].split(',')[1]))
          : LatLng(0, 0),
      nombreUsuarioCreacionArbol: json["nombreUsuarioCreacionArbol"],
      usuarioModificaArbol: json["usuarioModificaArbol"], // Tabla: usuario
      fechaCreacionArbol:
          DateTime.parse(json["fechaCreacionArbol"]), // Tabla: arbol_master
      fechaUltimaModArbol:
          DateTime.parse(json["fechaUltimaModArbol"]), // Tabla: arbol_master
      alertaArbol: json["alertaArbol"], // Tabla: arbol_master
      revisionArbol: json["revisionArbol"], // Tabla: arbol_master
    );
  }
}

class ListaDeArboles {
  final List<Arbol> listaArbol;
  ListaDeArboles({
    this.listaArbol,
  });
  factory ListaDeArboles.fromJson(List<dynamic> parsedJson) {
    List<Arbol> _listaDeArbol = List<Arbol>();
    _listaDeArbol = parsedJson.map((i) => Arbol.fromJson(i)).toList();
    return ListaDeArboles(listaArbol: _listaDeArbol);
  }
}
