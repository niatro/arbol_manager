import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutterapparbol/core/network/network_info.dart';
import 'package:flutterapparbol/core/util/input_converter.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_local_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/local_data_estructuras.dart';
import 'package:flutterapparbol/features/arbol/data/repositories/arboles_repositorio_impl.dart';
import 'package:flutterapparbol/features/arbol/domain/repositories/arboles_repositorio.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/actualizar_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arbol_por_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/grabar_arboles_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/login_usecase.dart';
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/arbol/domain/usecases/update_arboles_usecase.dart';

// sl = Service Locator
final sl = GetIt.instance;
Future<void> init() async {
  //OJO: Features (Arboles Entity....
  //Bloc registrado como un factory
  sl.registerFactory(
    () => ArbolesEntityBloc(
      arbolesCercanosUseCase: sl(),
      arbolPorIdNFCUseCase: sl(),
      grabarArbolUseCase: sl(),
      updateArbolesUseCase: sl(),
      comprobarIdNFCUseCase: sl(),
      leerIdNfcUseCase: sl(),
      actualizarDatosFormUseCase: sl(),
      getDatosFormUseCase: sl(),
      getCoordUseCase: sl(),
      loginUseCase: sl(),
      inputConverterFromIdNFCToStr: sl(),
      inputConverter: sl(),
    ),
  );
  // Use Cases que pueden ser singletones porque no necesitmos cerrarr streams
  //y no es StateFull
  sl.registerLazySingleton(() => GetArbolesCercanosUseCase(sl()));
  sl.registerLazySingleton(() => GetArbolPorIdNFCUseCase(sl()));
  sl.registerLazySingleton(() => GrabarArbolUseCase(sl()));
  sl.registerLazySingleton(() => UpdateArbolesUseCase(sl()));
  sl.registerLazySingleton(() => ComprobarIdNFCUseCase(sl()));
  sl.registerLazySingleton(() => LeerIdNfcUseCase(sl()));
  sl.registerLazySingleton(() => ActualizarDatosFormUseCase(sl()));
  sl.registerLazySingleton(() => GetDatosFormUseCase(sl()));
  sl.registerLazySingleton(() => GetCoordUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repositorios
  sl.registerLazySingleton<ArbolesRepositorio>(
    () => ArbolesRepositorioImpl(
        remoteDataSource: sl(),
        localDatasource: sl(),
        netWorkInfo: sl(),
        sqlDataSource: sl()),
  );
// Data Sources
  sl.registerLazySingleton<ArbolesRemoteDataSource>(
    () => ArbolesRemoteDataSourceImpl(
      client: sl(),
      databaseHelper: sl(),
      referencia: sl(),
    ),
  );
  sl.registerLazySingleton<ArbolesLocalDataSource>(
    () => ArbolesLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<FormLocalSourceSql>(
    () => FormLocalSourceSqlImpl(),
  );

  //OJO: Core (InputConverter, NetworkInfo)
  sl.registerLazySingleton(() => InputConverterIdNFCToStr());
  sl.registerLazySingleton(() => InputConverterStrToLatLng());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => EsquemaDataDeSQL());

  //OJO: External (SharedPreferences, http
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
