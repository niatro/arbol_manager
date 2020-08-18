import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutterapparbol/core/network/network_info.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_local_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/repositories/arboles_repositorio_impl.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arbol_por_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_arboles_usecase.dart';
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  //OJO: Features (Arboles Entity....
  //Bloc
  sl.registerFactory(
    () => ArbolesEntityBloc(
      arbolesCercanosUseCase: sl(),
      arbolPorIdNFCUseCase: sl(),
      grabarArbolesUseCase: sl(),
      comprobarIdNFCUseCase: sl(),
      inputConverterFromIdNFCToStr: sl(),
      inputConverter: sl(),
    ),
  );
  // Use Cases que pueden ser singletones porque no necesitmos cerrarr streams
  //y no es StateFull
  sl.registerLazySingleton(() => GetArbolesCercanosUseCase(sl()));
  sl.registerLazySingleton(() => GetArbolPorIdNFCUseCase(sl()));
  sl.registerLazySingleton(() => GrabarArbolesUseCase(sl()));
  sl.registerLazySingleton(() => ComprobarIdNFCUseCase(sl()));
  // Repositorios
  sl.registerLazySingleton<ArbolesRepositorio>(
    () => ArbolesRepositorioImpl(
      remoteDataSource: sl(),
      localDatasource: sl(),
      netWorkInfo: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<ArbolesRemoteDataSource>(
    () => ArbolesRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<ArbolesLocalDataSource>(
    () => ArbolesLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //OJO: Core (InputConverter, NetworkInfo)
  sl.registerLazySingleton(() => InputConverterIdNFCToStr());
  sl.registerLazySingleton(() => InputConverterStrToLatLng());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //OJO: External (SharedPreferences, http
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
