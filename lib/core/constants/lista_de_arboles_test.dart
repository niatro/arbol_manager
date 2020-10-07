import 'package:flutterapparbol/features/arbol/data/models/arboles_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

ArbolEntity arbolUno = ArbolEntity(
  guiArbol: "044a7252d96480",
  idArbol: 5647,
  idNfcHistoria: ["04cf8652d96480", "04cf8652d96480"],
  clienteArbol: "Vitacura",
  zonaArbol: "Unidad Vecinal A-5",
  calleArbol: "Alto Del Polo",
  nCalleArbol: 2345,
  esquinaCalleArbol: "Teresa Comas",
  especieArbol: "Populus nigra",
  diametroTroncoArbolCm: 40,
  diametroCopaNsArbolMt: 10.0,
  diametroCopaEoArbolMt: 8.0,
  alturaArbolArbolMt: 22.0,
  alturaCopaArbolMt: 7.0,
  estadoGeneralArbol: "Bueno",
  estadoSanitarioArbol: "Sano",
  enfermedad: Enfermedad(
      sintoma: "Fumagina", agentePatogeno: "Conchuelas", lugarPlaga: "Fuste"),
  inclinacionTroncoArbol: "Menor o igual a 30 grados",
  orientacionInclinacionArbol: "Calle",
  obsArbolHistoria: ["Chip roto", "revisar registro"],
  accionObsArbol: "Poda despeje de luminaria",
  segundaAccionObsArbol: "Poda despeje de luminaria",
  terceraAccionObsArbol: "Poda despeje de luminaria",
  geoReferenciaCapturaArbol: LatLng(-33.398827188275405, -70.59860965002224),
  nombreUsuarioCreacionArbol: "Elio Frugone",
  usuarioModificaArbol: "Nicolas Sanhueza",
  fechaCreacionArbol: DateTime(2018, 3, 28),
  fechaUltimaModArbol: DateTime(2019, 4, 22),
  alertaArbol: "No",
  revisionArbol: "Si",
  fotosArbol: ["foto1", "foto2"],
);

ArbolEntity arbolDos = ArbolEntity(
  guiArbol: "044a75652d96480",
  idArbol: 6648,
  idNfcHistoria: ["04cf8652d96480", "04cf8652d96480"],
  clienteArbol: "Vitacura",
  zonaArbol: "Unidad vecinal 5",
  calleArbol: "Nueva Costanera",
  nCalleArbol: 2345,
  esquinaCalleArbol: "Teresa Comas",
  especieArbol: "Ciruelo",
  diametroTroncoArbolCm: 40,
  diametroCopaNsArbolMt: 10.0,
  diametroCopaEoArbolMt: 8.0,
  alturaArbolArbolMt: 22.0,
  alturaCopaArbolMt: 7.0,
  estadoGeneralArbol: "bueno",
  estadoSanitarioArbol: "Sano",
  enfermedad: Enfermedad(
      sintoma: "Fumagina", agentePatogeno: "Conchuelas", lugarPlaga: "Fuste"),
  inclinacionTroncoArbol: "Menor o igual a 30 grados",
  orientacionInclinacionArbol: "Calle",
  obsArbolHistoria: ["mala foto", "revisar registro"],
  accionObsArbol: "Poda despeje de luminaria",
  segundaAccionObsArbol: "Poda despeje de luminaria",
  terceraAccionObsArbol: "Poda despeje de luminaria",
  geoReferenciaCapturaArbol: LatLng(-33.40022111646666, -70.59898554630922),
  nombreUsuarioCreacionArbol: "Elio Frugone",
  usuarioModificaArbol: "Nicolas Sanhueza",
  fechaCreacionArbol: DateTime(2018, 3, 28),
  fechaUltimaModArbol: DateTime(2019, 4, 22),
  alertaArbol: "No",
  revisionArbol: "Si",
  fotosArbol: ["foto1", "foto2"],
);
ArbolesEntity arbolesEntityTest = ArbolesEntity(listaArbolEntity: [
  arbolUno,
  arbolDos,
]);

ArbolEntityModelo arbolUnoModel = ArbolEntityModelo(
  guiArbol: "044a7252d96480",
  idArbol: 5647,
  idNfcHistoria: ["04cf8652d96480", "04cf8652d96480"],
  clienteArbol: "Vitacura",
  zonaArbol: "Unidad Vecinal A-5",
  calleArbol: "Alto Del Polo",
  nCalleArbol: 2345,
  esquinaCalleArbol: "Teresa Comas",
  especieArbol: "Populus nigra",
  diametroTroncoArbolCm: 40,
  diametroCopaNsArbolMt: 10.0,
  diametroCopaEoArbolMt: 8.0,
  alturaArbolArbolMt: 22.0,
  alturaCopaArbolMt: 7.0,
  estadoGeneralArbol: "Bueno",
  estadoSanitarioArbol: "Sano",
  enfermedad: Enfermedad(
      sintoma: "Fumagina", agentePatogeno: "Conchuelas", lugarPlaga: "Fuste"),
  inclinacionTroncoArbol: "Menor o igual a 30 grados",
  orientacionInclinacionArbol: "Calle",
  obsArbolHistoria: ["Chip roto", "revisar registro"],
  accionObsArbol: "Poda despeje de luminaria",
  segundaAccionObsArbol: "Poda despeje de luminaria",
  terceraAccionObsArbol: "Poda despeje de luminaria",
  geoReferenciaCapturaArbol: LatLng(-33.398827188275405, -70.59860965002224),
  nombreUsuarioCreacionArbol: "Elio Frugone",
  usuarioModificaArbol: "Nicolas Sanhueza",
  fechaCreacionArbol: DateTime(2018, 3, 28),
  fechaUltimaModArbol: DateTime(2019, 4, 22),
  alertaArbol: "No",
  revisionArbol: "Si",
  fotosArbol: ["foto1", "foto2"],
);

ArbolEntityModelo arbolDosModel = ArbolEntityModelo(
  guiArbol: "044a75652d96480",
  idArbol: 6648,
  idNfcHistoria: ["04cf8652d96480", "04cf8652d96480"],
  clienteArbol: "Vitacura",
  zonaArbol: "Unidad vecinal 5",
  calleArbol: "Nueva Costanera",
  nCalleArbol: 2345,
  esquinaCalleArbol: "Teresa Comas",
  especieArbol: "Ciruelo",
  diametroTroncoArbolCm: 40,
  diametroCopaNsArbolMt: 10.0,
  diametroCopaEoArbolMt: 8.0,
  alturaArbolArbolMt: 22.0,
  alturaCopaArbolMt: 7.0,
  estadoGeneralArbol: "bueno",
  estadoSanitarioArbol: "Sano",
  enfermedad: Enfermedad(
      sintoma: "Fumagina", agentePatogeno: "Conchuelas", lugarPlaga: "Fuste"),
  inclinacionTroncoArbol: "Menor o igual a 30 grados",
  orientacionInclinacionArbol: "Calle",
  obsArbolHistoria: ["mala foto", "revisar registro"],
  accionObsArbol: "Poda despeje de luminaria",
  segundaAccionObsArbol: "Poda despeje de luminaria",
  terceraAccionObsArbol: "Poda despeje de luminaria",
  geoReferenciaCapturaArbol: LatLng(-33.40022111646666, -70.59898554630922),
  nombreUsuarioCreacionArbol: "Elio Frugone",
  usuarioModificaArbol: "Nicolas Sanhueza",
  fechaCreacionArbol: DateTime(2018, 3, 28),
  fechaUltimaModArbol: DateTime(2019, 4, 22),
  alertaArbol: "No",
  revisionArbol: "Si",
  fotosArbol: ["foto1", "foto2"],
);
