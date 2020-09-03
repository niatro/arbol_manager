import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';

FormEntity formTest = FormEntity(
  clienteArbol: [ClienteEntity(clienteId: 1, clienteNombre: 'Vitacura')],
  zonaArbol: [
    ZonaEntity(zonaId: 1, zonaNombre: 'Unidad Vecinal 1', clienteId: 1)
  ],
  calleArbol: [
    CalleEntity(calleId: 1, calleZonaId: 1, calleNombre: 'Nueva Costanera')
  ],
  esquinaCalleArbol: [
    CalleEsquinaEntity(
      calleEsquinaId: 1,
      calleEsquinaZonaId: 1,
      calleEsquinaNombre: 'Vicente Rozales',
    )
  ],
  especieArbol: [
    EspecieEntity(
      especieIdOrigen: 1,
      especieNombreCientifico: 'Pinus Radiata',
      especieNombreComun: 'Pino',
      especieOrden: 3,
      especieIcono: 'assets/icon/....',
      especieHojaGenerica: 'assets/hojas/..',
      especieFotoGenerica: 'assets/fotos/...',
      especieDescripcion: 'omnis facus rebes dios cauh d dewdfef',
    )
  ],
  estadoGeneralArbol: [
    EstadoGeneralEntity(estadoGeneralId: 2, estadoGeneralIdDesc: 'Bueno')
  ],
  estadoSanitarioArbol: [
    EstadoSanitarioEntity(
        estadoSanitarioId: 1, estadoSanitarioDesc: 'Hongos en la punta')
  ],
  inclinacionTroncoArbol: [
    InclinacionTroncoEntity(
        inclinacionTroncoId: 1, inclinacionTroncoDesc: 'Muy inclinado')
  ],
  orientacionInclinacionArbol: [
    OrientacionInclinacionEntity(
        orientacionInclinacionId: 1, orientacionInclinacionDesc: 'A la vereda')
  ],
  accionObsArbol: [
    AccionObsEntity(
        accionObsId: 1, accionObsDesc: 'podar ramas', accionObsOrden: 2)
  ],
);

FormEntity formTestModelo = FormEntityModelo(
  clienteArbol: [ClienteEntity(clienteId: 1, clienteNombre: 'Vitacura')],
  zonaArbol: [
    ZonaEntity(zonaId: 1, zonaNombre: 'Unidad Vecinal 1', clienteId: 1)
  ],
  calleArbol: [
    CalleEntity(calleId: 1, calleZonaId: 1, calleNombre: 'Nueva Costanera')
  ],
  esquinaCalleArbol: [
    CalleEsquinaEntity(
      calleEsquinaId: 1,
      calleEsquinaZonaId: 1,
      calleEsquinaNombre: 'Vicente Rozales',
    )
  ],
  especieArbol: [
    EspecieEntity(
      especieIdOrigen: 1,
      especieNombreCientifico: 'Pinus Radiata',
      especieNombreComun: 'Pino',
      especieOrden: 3,
      especieIcono: 'assets/icon/....',
      especieHojaGenerica: 'assets/hojas/..',
      especieFotoGenerica: 'assets/fotos/...',
      especieDescripcion: 'omnis facus rebes dios cauh d dewdfef',
    )
  ],
  estadoGeneralArbol: [
    EstadoGeneralEntity(estadoGeneralId: 2, estadoGeneralIdDesc: 'Bueno')
  ],
  estadoSanitarioArbol: [
    EstadoSanitarioEntity(
        estadoSanitarioId: 1, estadoSanitarioDesc: 'Hongos en la punta')
  ],
  inclinacionTroncoArbol: [
    InclinacionTroncoEntity(
        inclinacionTroncoId: 1, inclinacionTroncoDesc: 'Muy inclinado')
  ],
  orientacionInclinacionArbol: [
    OrientacionInclinacionEntity(
        orientacionInclinacionId: 1, orientacionInclinacionDesc: 'A la vereda')
  ],
  accionObsArbol: [
    AccionObsEntity(
        accionObsId: 1, accionObsDesc: 'podar ramas', accionObsOrden: 2)
  ],
);

ClienteEntity tClienteUno =
    ClienteEntity(clienteId: 1, clienteNombre: 'Vitacura');
ClienteEntity tClienteDos =
    ClienteEntity(clienteId: 2, clienteNombre: 'Las Condes');
List<Map> tClientesListados = [
  {'clienteId': 1, 'clienteNombre': 'Vitacura'},
  {'clienteId': 2, 'clienteNombre': 'Las Condes'},
];

ClienteModelo tClienteUnoModeloExp = ClienteModelo(clienteNombre: 'Vitacura');
ZonaModelo tZonaModeloExp = ZonaModelo(
  clienteId: 1,
  zonaNombre: 'Unidad Vecinal 4',
);
