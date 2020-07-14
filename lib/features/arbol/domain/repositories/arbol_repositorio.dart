import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/success.dart';
import '../entities/lista_de_arboles.dart';

abstract class ArbolRepositorio {
  Future<Either<Failure, ListaDeArboles>> getListadoArbolesCercanos(
      LatLng coordenadas);
  Future<Either<Failure, ListaDeArboles>> grabarListaDeArbolesLevantados(
      ListaDeArboles listaDeArboles);
  Future<Either<Failure, Success>> agregarArbolPorNFC(String idNFC);
  Future<Either<Failure, Success>> agregarArbolPorMapa(String idRandomNFC);
  Future<Either<Failure, Success>> editarArbolConNFC(int idArbol);
  Future<Either<Failure, Success>> editarArbolPorMapa(int idArbol);
}
