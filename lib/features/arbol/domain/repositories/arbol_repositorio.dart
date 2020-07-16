import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/success.dart';
import '../entities/lista_de_arboles.dart';

abstract class ListaArbolRepositorio {
  Future<Either<Failure, ListaDeArboles>> getListadoArbolesCercanos(
      LatLng coordenadas);
  // Esto esta mal porque no se necesita devolver una entidad de ListaDeArboles
  // Solo necesito que la operacion se haya realizado correctamente
  Future<Either<Failure, bool>> grabarListaDeArbolesLevantadosOneByOne(
      ListaDeArboles listaDeArboles);
  Future<Either<Failure, bool>> comprobarExistenciaIdNFC(String idNFC);
  Future<Either<Failure, ListaDeArboles>> getArbolPorIdNFC(String idNFC);
  Future<Either<Failure, String>> fromChipReadAndGetIdNFC();

// Los métodos abajo deberían ir en el layer de presentación
/*Future<Either<Failure, Success>> agregarArbolPorNFC(String idNFC);
  Future<Either<Failure, Success>> agregarArbolPorMapa(String idRandomNFC);
  Future<Either<Failure, Success>> editarArbolConNFC(int idArbol);
  Future<Either<Failure, Success>> editarArbolPorMapa(int idArbol);*/
}
