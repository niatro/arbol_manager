import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/arboles_entity.dart';
import 'package:meta/meta.dart';

class ArbolesEntityModelo extends ArbolesEntity {
  ArbolesEntityModelo({
    @required List<ArbolEntity> listaArbolesEntity,
  }) : super(listaArbolEntity: listaArbolesEntity);
  factory ArbolesEntityModelo.fromJson(
      {List<Map<String, dynamic>> parsedListMapFromJson}) {
    List<ArbolEntityModelo> _listaDeArbol = List<ArbolEntityModelo>();
    _listaDeArbol = parsedListMapFromJson
        .map((i) => ArbolEntityModelo.fromJson(i))
        .toList();
    return ArbolesEntityModelo(listaArbolesEntity: _listaDeArbol);
  }

  List<Map<String, dynamic>> toMapFromArbolesEntityModelo() {
    List<ArbolEntityModelo> data = List<ArbolEntityModelo>();
    data = [];
    final int nArbolesModelo = this.listaArbolEntity.length;
    for (var i = 0; i < nArbolesModelo; i++) {
      ArbolEntityModelo arbolEntityModelo = ArbolEntityModelo(
        guiArbol: this.listaArbolEntity[i].guiArbol,
        idArbol: this.listaArbolEntity[i].idArbol,
        idNfcHistoria: this.listaArbolEntity[i].idNfcHistoria,
        clienteArbol: this.listaArbolEntity[i].clienteArbol,
        zonaArbol: this.listaArbolEntity[i].zonaArbol,
        calleArbol: this.listaArbolEntity[i].calleArbol,
        nCalleArbol: this.listaArbolEntity[i].nCalleArbol,
        esquinaCalleArbol: this.listaArbolEntity[i].esquinaCalleArbol,
        especieArbol: this.listaArbolEntity[i].especieArbol,
        diametroTroncoArbolCm: this.listaArbolEntity[i].diametroTroncoArbolCm,
        diametroCopaNsArbolMt: this.listaArbolEntity[i].diametroCopaNsArbolMt,
        diametroCopaEoArbolMt: this.listaArbolEntity[i].diametroCopaEoArbolMt,
        alturaArbolArbolMt: this.listaArbolEntity[i].alturaArbolArbolMt,
        alturaCopaArbolMt: this.listaArbolEntity[i].alturaCopaArbolMt,
        estadoGeneralArbol: this.listaArbolEntity[i].estadoGeneralArbol,
        estadoSanitarioArbol: this.listaArbolEntity[i].estadoSanitarioArbol,
        enfermedad: this.listaArbolEntity[i].enfermedad,
        inclinacionTroncoArbol: this.listaArbolEntity[i].inclinacionTroncoArbol,
        orientacionInclinacionArbol:
            this.listaArbolEntity[i].orientacionInclinacionArbol,
        obsArbolHistoria: this.listaArbolEntity[i].obsArbolHistoria,
        accionObsArbol: this.listaArbolEntity[i].accionObsArbol,
        segundaAccionObsArbol: this.listaArbolEntity[i].segundaAccionObsArbol,
        terceraAccionObsArbol: this.listaArbolEntity[i].terceraAccionObsArbol,
        geoReferenciaCapturaArbol:
            this.listaArbolEntity[i].geoReferenciaCapturaArbol,
        nombreUsuarioCreacionArbol:
            this.listaArbolEntity[i].nombreUsuarioCreacionArbol,
        usuarioModificaArbol: this.listaArbolEntity[i].usuarioModificaArbol,
        fechaCreacionArbol: this.listaArbolEntity[i].fechaCreacionArbol,
        fechaUltimaModArbol: this.listaArbolEntity[i].fechaUltimaModArbol,
        alertaArbol: this.listaArbolEntity[i].alertaArbol,
        revisionArbol: this.listaArbolEntity[i].revisionArbol,
        fotosArbol: this.listaArbolEntity[i].fotosArbol,
        fotosEnfermedad: this.listaArbolEntity[i].fotosEnfermedad,
      );
      data.add(arbolEntityModelo);
    }
    List<Map<String, dynamic>> _listaMaps = List<Map<String, dynamic>>();
    for (ArbolEntityModelo arbol in data) {
      _listaMaps.add(arbol.toJson());
    }
    return _listaMaps;
  }
}

class ArbolEntityModelo extends ArbolEntity {
  ArbolEntityModelo({
    @required String guiArbol,
    @required int idArbol,
    @required List<dynamic> idNfcHistoria,
    @required String clienteArbol,
    @required String zonaArbol,
    @required String calleArbol,
    @required int nCalleArbol,
    @required String esquinaCalleArbol,
    @required String especieArbol,
    @required int diametroTroncoArbolCm,
    @required double diametroCopaNsArbolMt,
    @required double diametroCopaEoArbolMt,
    @required double alturaArbolArbolMt,
    @required double alturaCopaArbolMt,
    @required String estadoGeneralArbol,
    @required String estadoSanitarioArbol,
    @required Enfermedad enfermedad,
    @required String inclinacionTroncoArbol,
    @required String orientacionInclinacionArbol,
    @required List<dynamic> obsArbolHistoria,
    @required String accionObsArbol,
    @required String segundaAccionObsArbol,
    @required String terceraAccionObsArbol,
    @required LatLng geoReferenciaCapturaArbol,
    @required String nombreUsuarioCreacionArbol,
    @required String usuarioModificaArbol,
    @required DateTime fechaCreacionArbol,
    @required DateTime fechaUltimaModArbol,
    @required String alertaArbol,
    @required String revisionArbol,
    @required List<dynamic> fotosArbol,
    @required List<dynamic> fotosEnfermedad,
  }) : super(
          guiArbol: guiArbol,
          idArbol: idArbol,
          idNfcHistoria: idNfcHistoria,
          clienteArbol: clienteArbol,
          zonaArbol: zonaArbol,
          calleArbol: calleArbol,
          nCalleArbol: nCalleArbol,
          esquinaCalleArbol: esquinaCalleArbol,
          especieArbol: especieArbol,
          diametroTroncoArbolCm: diametroTroncoArbolCm,
          diametroCopaNsArbolMt: diametroCopaNsArbolMt,
          diametroCopaEoArbolMt: diametroCopaEoArbolMt,
          alturaArbolArbolMt: alturaArbolArbolMt,
          alturaCopaArbolMt: alturaCopaArbolMt,
          estadoGeneralArbol: estadoGeneralArbol,
          estadoSanitarioArbol: estadoSanitarioArbol,
          enfermedad: enfermedad,
          inclinacionTroncoArbol: inclinacionTroncoArbol,
          orientacionInclinacionArbol: orientacionInclinacionArbol,
          obsArbolHistoria: obsArbolHistoria,
          accionObsArbol: accionObsArbol,
          segundaAccionObsArbol: segundaAccionObsArbol,
          terceraAccionObsArbol: terceraAccionObsArbol,
          geoReferenciaCapturaArbol: geoReferenciaCapturaArbol,
          nombreUsuarioCreacionArbol: nombreUsuarioCreacionArbol,
          usuarioModificaArbol: usuarioModificaArbol,
          fechaCreacionArbol: fechaCreacionArbol,
          fechaUltimaModArbol: fechaUltimaModArbol,
          alertaArbol: alertaArbol,
          revisionArbol: revisionArbol,
          fotosArbol: fotosArbol,
          fotosEnfermedad: fotosEnfermedad,
        );
  factory ArbolEntityModelo.fromJson(Map<String, dynamic> json) {
    return ArbolEntityModelo(
      guiArbol: json["guiArbol"],
      idArbol: int.parse(json["idArbol"]),
      idNfcHistoria: json["idNfcHistoria"],
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
      enfermedad: json['enfermedad'] != null
          ? Enfermedad.fromJson(json['enfermedad'])
          : null,
      inclinacionTroncoArbol: json["inclinacionTroncoArbol"],
      orientacionInclinacionArbol: json["orientacionInclinacionArbol"],
      obsArbolHistoria: json["obsArbolHistoria"], // tabla: observaciones_arbol
      accionObsArbol: json["accionObsArbol"],
      segundaAccionObsArbol: json["segundaAccionObsArbol"],
      terceraAccionObsArbol: json["terceraAccionObsArbol"],
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
      revisionArbol: json["revisionArbol"],
      fotosArbol: json["fotosArbol"], // Tabla: arbol_master
      fotosEnfermedad: json["fotosEnfermedad"],
    );
  }
//En el proseso de serialización estamos creando un mapa <String, dinamico>
  // que es diferente del JSON que recibimos que viene <Sting, String>
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['guiArbol'] = this.guiArbol;
    data['idArbol'] = this.idArbol.toString();
    data['idNfcHistoria'] = this.idNfcHistoria;
    data['clienteArbol'] = this.clienteArbol;
    data['zonaArbol'] = this.zonaArbol;
    data['calleArbol'] = this.calleArbol;
    data['nCalleArbol'] = this.nCalleArbol.toString();
    data['esquinaCalleArbol'] = this.esquinaCalleArbol;
    data['especieArbol'] = this.especieArbol;
    data['diametroTroncoArbolCm'] = this.diametroTroncoArbolCm.toString();
    data['diametroCopaNsArbolMt'] = this.diametroCopaNsArbolMt.toString();
    data['diametroCopaEoArbolMt'] = this.diametroCopaEoArbolMt.toString();
    data['alturaArbolArbolMt'] = this.alturaArbolArbolMt.toString();
    data['alturaCopaArbolMt'] = this.alturaCopaArbolMt.toString();
    data['estadoGeneralArbol'] = this.estadoGeneralArbol;
    data['estadoSanitarioArbol'] = this.estadoSanitarioArbol;
    data['enfermedad'] = this.enfermedad.toJson();
    data['inclinacionTroncoArbol'] = this.inclinacionTroncoArbol;
    data['orientacionInclinacionArbol'] = this.orientacionInclinacionArbol;
    data['obsArbolHistoria'] = this.obsArbolHistoria;
    data['accionObsArbol'] = this.accionObsArbol;
    data['geoReferenciaCapturaArbol'] =
        this.geoReferenciaCapturaArbol.latitude.toString() +
            ',' +
            this.geoReferenciaCapturaArbol.longitude.toString();
    data['nombreUsuarioCreacionArbol'] = this.nombreUsuarioCreacionArbol;
    data['usuarioModificaArbol'] = this.usuarioModificaArbol;
    data['fechaCreacionArbol'] = this.fechaCreacionArbol.toString();
    data['fechaUltimaModArbol'] = this.fechaUltimaModArbol.toString();
    data['alertaArbol'] = this.alertaArbol;
    data['revisionArbol'] = this.revisionArbol;
    data['fotosArbol'] = this.fotosArbol;
    data['fotosEnfermedad'] = this.fotosEnfermedad;
    return data;
  }
}
