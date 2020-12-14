// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:http/http.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'features/arbol/data/datasources/arboles_local_data_source.dart';
import 'features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'features/arbol/domain/repositories/arboles_repositorio.dart';
import 'features/arbol/data/repositories/arboles_repositorio_impl.dart';
import 'features/arbol/application/auth/auth_bloc.dart';
import 'features/arbol/domain/usecases/comprobar_idnfc_usecase.dart';
import 'features/arbol/data/core/dataconectioncheker_injectable_module.dart';
import 'features/arbol/data/datasources/local_data_estructuras.dart';
import 'features/arbol/data/auth/firebase_auth_facade.dart';
import 'features/arbol/data/core/firebase_injectable_module.dart';
import 'features/arbol/data/datasources/form_local_source_sql.dart';
import 'features/arbol/domain/usecases/get_arbol_por_idnfc_usecase.dart';
import 'features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'features/arbol/data/core/http_injectable_module.dart';
import 'features/arbol/domain/auth/i_auth_facade.dart';
import 'features/arbol/data/core/sharedpreferences_injectable_module.dart';
import 'core/util/input_converter.dart';
import 'features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'core/network/network_info.dart';
import 'features/arbol/application/nfc/nfc_bloc.dart';
import 'features/arbol/application/auth/sign_in_form/sign_in_form_bloc.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final httpModule = _$HttpModule();
  final dataConnectionCheckerModule = _$DataConnectionCheckerModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<Client>(() => httpModule.httpClient);
  gh.lazySingleton<DataConnectionChecker>(
      () => dataConnectionCheckerModule.dataConectionChecker);
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FormLocalSourceSql>(() => FormLocalSourceSqlImpl());
  gh.lazySingleton<GoogleSignIn>(() => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<IAuthFacade>(
      () => FirebaseAuthFacade(get<FirebaseAuth>(), get<GoogleSignIn>()));
  gh.lazySingleton<InputConverterIdNFCToStr>(() => InputConverterIdNFCToStr());
  gh.lazySingleton<InputConverterStrToLatLng>(
      () => InputConverterStrToLatLng());
  gh.lazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(get<DataConnectionChecker>()));
  final sharedPreferences = await injectableModule.prefs;
  gh.factory<SharedPreferences>(() => sharedPreferences);
  gh.factory<SignInFormBloc>(() => SignInFormBloc(get<IAuthFacade>()));
  gh.lazySingleton<ArbolesLocalDataSource>(() =>
      ArbolesLocalDataSourceImpl(sharedPreferences: get<SharedPreferences>()));
  gh.lazySingleton<ArbolesRemoteDataSource>(() => ArbolesRemoteDataSourceImpl(
      client: get<Client>(), referencia: get<EsquemaDataDeSQL>()));
  gh.lazySingleton<ArbolesRepositorio>(() => ArbolesRepositorioImpl(
        remoteDataSource: get<ArbolesRemoteDataSource>(),
        localDatasource: get<ArbolesLocalDataSource>(),
        netWorkInfo: get<NetworkInfo>(),
        sqlDataSource: get<FormLocalSourceSql>(),
      ));
  gh.factory<AuthBloc>(() => AuthBloc(get<IAuthFacade>()));
  gh.lazySingleton<ComprobarIdNfcUseCase>(
      () => ComprobarIdNfcUseCase(get<ArbolesRepositorio>()));
  gh.factory<GetArbolPorIdNFCUseCase>(
      () => GetArbolPorIdNFCUseCase(get<ArbolesRepositorio>()));
  gh.lazySingleton<GetArbolesCercanosUseCase>(
      () => GetArbolesCercanosUseCase(get<ArbolesRepositorio>()));
  gh.lazySingleton<GetCoordUseCase>(
      () => GetCoordUseCase(get<ArbolesRepositorio>()));
  gh.lazySingleton<LeerIdNfcUseCase>(
      () => LeerIdNfcUseCase(get<ArbolesRepositorio>()));
  gh.factory<NfcBloc>(() => NfcBloc(
        getArbolPorIdNFCUseCase: get<GetArbolPorIdNFCUseCase>(),
        leerIdNfcUseCase: get<LeerIdNfcUseCase>(),
        comprobarIdNfcUseCase: get<ComprobarIdNfcUseCase>(),
      ));
  gh.factory<ArbolMapaBloc>(() => ArbolMapaBloc(
        arbolesCercanosUseCase: get<GetArbolesCercanosUseCase>(),
        arbolPorIdNfcUseCase: get<GetArbolPorIdNFCUseCase>(),
        comprobarIdNFCUseCase: get<ComprobarIdNfcUseCase>(),
        leerIdNfcUseCase: get<LeerIdNfcUseCase>(),
        getCoordUseCase: get<GetCoordUseCase>(),
        inputConverter: get<InputConverterStrToLatLng>(),
        inputConverterFromIdNFCToStr: get<InputConverterIdNFCToStr>(),
      ));

  // Eager singletons must be registered in the right order
  gh.singleton<EsquemaDataDeSQL>(EsquemaDataDeSQL());
  return get;
}

class _$HttpModule extends HttpModule {}

class _$DataConnectionCheckerModule extends DataConnectionCheckerModule {}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}

class _$InjectableModule extends InjectableModule {}
