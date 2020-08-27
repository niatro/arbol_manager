import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class FormEntity extends Equatable {
  final String guiArbol;
  final int idArbol;
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
  final String accionObsArbol;
  final LatLng geoReferenciaCapturaArbol;
  final String alertaArbol;
  final String revisionArbol;

  FormEntity({
    @required this.guiArbol,
    @required this.idArbol,
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
    @required this.accionObsArbol,
    @required this.geoReferenciaCapturaArbol,
    @required this.alertaArbol,
    @required this.revisionArbol,
  }) : super([
          guiArbol,
          idArbol,
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
          accionObsArbol,
          geoReferenciaCapturaArbol,
          alertaArbol,
          revisionArbol,
        ]);
}
