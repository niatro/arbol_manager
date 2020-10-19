import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class ArbolEntity extends Equatable {
  final String guiArbol;
  final int idArbol;
  final List<dynamic> idNfcHistoria;
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
  final Enfermedad enfermedad;
  final String inclinacionTroncoArbol;
  final String orientacionInclinacionArbol;
  final List<dynamic> obsArbolHistoria;
  final String accionObsArbol;
  final String segundaAccionObsArbol;
  final String terceraAccionObsArbol;
  final LatLng geoReferenciaCapturaArbol;
  final String nombreUsuarioCreacionArbol;
  final String usuarioModificaArbol;
  final DateTime fechaCreacionArbol;
  final DateTime fechaUltimaModArbol;
  final String alertaArbol;
  final String revisionArbol;
  final List<dynamic> fotosArbol;
  final List<dynamic> fotosEnfermedad;

  ArbolEntity({
    @required this.guiArbol,
    @required this.idArbol,
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
    @required this.enfermedad,
    @required this.inclinacionTroncoArbol,
    @required this.orientacionInclinacionArbol,
    @required this.obsArbolHistoria,
    @required this.accionObsArbol,
    @required this.segundaAccionObsArbol,
    @required this.terceraAccionObsArbol,
    @required this.geoReferenciaCapturaArbol,
    @required this.nombreUsuarioCreacionArbol,
    @required this.usuarioModificaArbol,
    @required this.fechaCreacionArbol,
    @required this.fechaUltimaModArbol,
    @required this.alertaArbol,
    @required this.revisionArbol,
    @required this.fotosArbol,
    @required this.fotosEnfermedad,
  }) : super([
          guiArbol,
          idArbol,
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
          enfermedad,
          inclinacionTroncoArbol,
          orientacionInclinacionArbol,
          obsArbolHistoria,
          accionObsArbol,
          segundaAccionObsArbol,
          terceraAccionObsArbol,
          geoReferenciaCapturaArbol,
          nombreUsuarioCreacionArbol,
          usuarioModificaArbol,
          fechaCreacionArbol,
          fechaUltimaModArbol,
          alertaArbol,
          revisionArbol,
          fotosArbol,
          fotosEnfermedad,
        ]);
}

class ArbolesEntity extends Equatable {
  final List<ArbolEntity> listaArbolEntity;
  ArbolesEntity({
    @required this.listaArbolEntity,
  }) : super([listaArbolEntity]);
}

class Enfermedad extends Equatable {
  String sintoma;
  String agentePatogeno;
  String lugarPlaga;

  Enfermedad({this.sintoma, this.agentePatogeno, this.lugarPlaga});

  Enfermedad.fromJson(Map<String, dynamic> json) {
    sintoma = json['sintoma'];
    agentePatogeno = json['agentePatogeno'];
    lugarPlaga = json['lugarPlaga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sintoma'] = this.sintoma;
    data['agentePatogeno'] = this.agentePatogeno;
    data['lugarPlaga'] = this.lugarPlaga;
    return data;
  }
}
