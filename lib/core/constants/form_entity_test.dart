import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';

FormEntity formTest = FormEntity(
  clienteArbol: [Cliente(clienteId: 1, clienteNombre: 'Vitacura')],
  zonaArbol: [Zona(zonaId: 1, zonaNombre: 'Unidad Vecinal 1')],
  calleArbol: [
    Calle(calleId: 1, calleZonaId: 1, calleNombre: 'Nueva Costanera')
  ],
  esquinaCalleArbol: [
    CalleEsquina(
      calleEsquinaId: 1,
      calleEsquinaZonaId: 1,
      calleEsquinaNombre: 'Vicente Rozales',
    )
  ],
  especieArbol: [
    Especie(
      especieId: 1,
      especieNombreCientifico: 'Pinus Radiata',
      especieNombreComun: 'Pino',
      orden: 3,
      icono: 'assets/icon/....',
      hojaGenerica: 'assets/hojas/..',
      fotoGenerica: 'assets/fotos/...',
      descripcion: 'omnis facus rebes dios cauh d dewdfef',
    )
  ],
  estadoGeneralArbol: [
    EstadoGeneral(estadoGeneralId: 2, estadoGeneralIdDesc: 'Bueno')
  ],
  estadoSanitarioArbol: [
    EstadoSanitario(
        estadoSanitarioId: 1, estadoSanitarioDesc: 'Hongos en la punta')
  ],
  inclinacionTroncoArbol: [
    InclinacionTronco(
        inclinacionTroncoId: 1, inclinacionTroncoDesc: 'Muy inclinado')
  ],
  orientacionInclinacionArbol: [
    OrientacionInclinacion(
        orientacionInclinacionId: 1, orientacionInclinacionDesc: 'A la vereda')
  ],
  accionObsArbol: [
    AccionObs(accionObsId: 1, accionObsDesc: 'podar ramas', accionObsOrden: 2)
  ],
);

FormEntity formTestModelo = FormEntityModelo(
  clienteArbol: [Cliente(clienteId: 1, clienteNombre: 'Vitacura')],
  zonaArbol: [Zona(zonaId: 1, zonaNombre: 'Unidad Vecinal 1')],
  calleArbol: [
    Calle(calleId: 1, calleZonaId: 1, calleNombre: 'Nueva Costanera')
  ],
  esquinaCalleArbol: [
    CalleEsquina(
      calleEsquinaId: 1,
      calleEsquinaZonaId: 1,
      calleEsquinaNombre: 'Vicente Rozales',
    )
  ],
  especieArbol: [
    Especie(
      especieId: 1,
      especieNombreCientifico: 'Pinus Radiata',
      especieNombreComun: 'Pino',
      orden: 3,
      icono: 'assets/icon/....',
      hojaGenerica: 'assets/hojas/..',
      fotoGenerica: 'assets/fotos/...',
      descripcion: 'omnis facus rebes dios cauh d dewdfef',
    )
  ],
  estadoGeneralArbol: [
    EstadoGeneral(estadoGeneralId: 2, estadoGeneralIdDesc: 'Bueno')
  ],
  estadoSanitarioArbol: [
    EstadoSanitario(
        estadoSanitarioId: 1, estadoSanitarioDesc: 'Hongos en la punta')
  ],
  inclinacionTroncoArbol: [
    InclinacionTronco(
        inclinacionTroncoId: 1, inclinacionTroncoDesc: 'Muy inclinado')
  ],
  orientacionInclinacionArbol: [
    OrientacionInclinacion(
        orientacionInclinacionId: 1, orientacionInclinacionDesc: 'A la vereda')
  ],
  accionObsArbol: [
    AccionObs(accionObsId: 1, accionObsDesc: 'podar ramas', accionObsOrden: 2)
  ],
);
