import 'package:flutterapparbol/features/arbol/data/models/form_entity_modelo.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';

FormEntity formTest = FormEntity(
  clienteArbol: [ClienteEntity(clienteOrigenId: 1, clienteNombre: 'Vitacura')],
  zonaArbol: [
    ZonaEntity(zonaOrigenId: 1, zonaNombre: 'Unidad Vecinal 1', clienteId: 1)
  ],
  calleArbol: [
    CalleEntity(
      calleTipo: 'avenida',
      calleOrigenId: 1,
      calleZonaId: 1,
      calleNombre: 'Nueva Costanera',
    )
  ],
  esquinaCalleArbol: [
    CalleEsquinaEntity(
      calleEsquinaTipo: 'vereda',
      calleEsquinaOrigenId: 1,
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
    EstadoGeneralEntity(estadoGeneralOrigenId: 2, estadoGeneralDesc: 'Bueno')
  ],
  estadoSanitarioArbol: [
    EstadoSanitarioEntity(
        estadoSanitarioOrigenId: 1, estadoSanitarioDesc: 'Hongos en la punta')
  ],
  inclinacionTroncoArbol: [
    InclinacionTroncoEntity(
        inclinacionTroncoOrigenId: 1, inclinacionTroncoDesc: 'Muy inclinado')
  ],
  orientacionInclinacionArbol: [
    OrientacionInclinacionEntity(
        orientacionInclinacionOrigenId: 1,
        orientacionInclinacionDesc: 'A la vereda')
  ],
  accionObsArbol: [
    AccionObsEntity(
        accionObsOrigenId: 1, accionObsDesc: 'podar ramas', accionObsOrden: 2)
  ],
  usuarios: [
    UsuarioEntity(
        usuarioOrigenId: 1,
        usuarioGUI: 'sferwUg6k',
        usuarioCliente: 1,
        usuarioRol: 2,
        usarioNombre: 'Juan Pablo',
        usuarioApellido: 'Fernandez',
        usuarioEmail: 'fernandez@gmail.com',
        usuarioCreacion: '2018-07-07',
        usuarioActividad: 'si')
  ],
  agentesPatogenos: [
    AgentePatogenoEntity(
        agentePatogenoOrigenId: 1, agentePatogenoDesc: 'Plaga Mala')
  ],
  lugaresPlaga: [
    LugarPlagaEntity(lugarPlagaOrigenId: 2, lugarPlagaDesc: 'ramillas')
  ],
  plagas: [PlagaEntity(plagaOrigenId: 3, plagaDesc: 'Pulgones', plagaId: 2)],
  sintomas: [SintomaModelo(sintomaOrigenId: 1, sintomaDesc: 'Aserrin')],
);

FormEntityModelo tFormTestModelo = FormEntityModelo(
  clientes: [ClienteModelo(clienteOrigenId: 1, clienteNombre: 'Vitacura')],
  zonas: [
    ZonaModelo(zonaOrigenId: 1, zonaNombre: 'Unidad Vecinal 1', clienteId: 1)
  ],
  calles: [
    CalleModelo(
        calleTipo: 'avenida',
        calleOrigenId: 1,
        calleZonaId: 1,
        calleNombre: 'Nueva Costanera')
  ],
  esquinaCalles: [
    CalleEsquinaModelo(
      calleEsquinaTipo: 'vereda',
      calleEsquinaOrigenId: 1,
      calleEsquinaZonaId: 1,
      calleEsquinaNombre: 'Vicente Rozales',
    )
  ],
  especies: [
    EspecieModelo(
      especieOrigenId: 1,
      especieNombreCientifico: 'Pinus Radiata',
      especieNombreComun: 'Pino',
      especieOrden: 3,
      especieIcono: 'assets/icon/....',
      especieHojaGenerica: 'assets/hojas/..',
      especieFotoGenerica: 'assets/fotos/...',
      especieDescripcion: 'omnis facus rebes dios cauh d dewdfef',
    )
  ],
  estadosGenerales: [
    EstadoGeneralModelo(estadoGeneralOrigenId: 2, estadoGeneralDesc: 'Bueno')
  ],
  estadosSanitarios: [
    EstadoSanitarioModelo(
        estadoSanitarioOrigenId: 1, estadoSanitarioDesc: 'Hongos en la punta')
  ],
  inclinacionesTronco: [
    InclinacionTroncoModelo(
        inclinacionTroncoOrigenId: 1, inclinacionTroncoDesc: 'Muy inclinado')
  ],
  orientacionesInclinacion: [
    OrientacionInclinacionModelo(
        orientacionInclinacionOrigenId: 1,
        orientacionInclinacionDesc: 'A la vereda')
  ],
  accionesObs: [
    AccionObsModelo(
        accionObsOrigenId: 1, accionObsDesc: 'podar ramas', accionObsOrden: 2)
  ],
  usuarios: [
    UsuarioModelo(
        usuarioOrigenId: 1,
        usuarioGUI: 'sferwUg6k',
        usuarioCliente: 1,
        usuarioRol: 2,
        usarioNombre: 'Juan Pablo',
        usuarioApellido: 'Fernandez',
        usuarioEmail: 'fernandez@gmail.com',
        usuarioCreacion: '2018-07-07',
        usuarioActividad: 'si')
  ],
  agentesPatogenos: [
    AgentePatogenoModelo(
        agentePatogenoOrigenId: 1, agentePatogenoDesc: 'Plaga Mala')
  ],
  lugaresPlaga: [
    LugarPlagaModelo(lugarPlagaOrigenId: 2, lugarPlagaDesc: 'ramillas')
  ],
  plagas: [PlagaModelo(plagaOrigenId: 3, plagaDesc: 'Pulgones')],
  sintomas: [SintomaModelo(sintomaOrigenId: 1, sintomaDesc: 'Aserrin')],
);

ClienteEntity tClienteUno =
    ClienteEntity(clienteOrigenId: 1, clienteNombre: 'Vitacura');
ClienteEntity tClienteDos =
    ClienteEntity(clienteOrigenId: 2, clienteNombre: 'Las Condes');
List<Map> tClientesListados = [
  {'clienteId': 1, 'clienteNombre': 'Vitacura'},
  {'clienteId': 2, 'clienteNombre': 'Las Condes'},
];

ClienteModelo tClienteUnoModeloExp =
    ClienteModelo(clienteNombre: 'Vitacura', clienteOrigenId: 1);
ZonaModelo tZonaModeloExp = ZonaModelo(
  clienteId: 1,
  zonaNombre: 'Unidad Vecinal 4',
);
