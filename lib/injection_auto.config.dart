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
import 'features/arbol/data/datasources/local_data_estructuras.dart';
import 'features/arbol/data/auth/firebase_auth_facade.dart';
import 'features/arbol/data/core/firebase_injectable_module.dart';
import 'features/arbol/data/datasources/form_local_source_sql.dart';
import 'features/arbol/domain/usecases/get_arboles_cercanos_usecase.dart';
import 'features/arbol/domain/usecases/get_coordenadas_usecase.dart';
import 'features/arbol/domain/auth/i_auth_facade.dart';
import 'core/util/input_converter.dart';
import 'features/arbol/domain/usecases/leer_idnfc_usecase.dart';
import 'core/network/network_info.dart';
import 'features/arbol/application/auth/sign_in_form/sign_in_form_bloc.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<ArbolesLocalDataSourceImpl>(() =>
      ArbolesLocalDataSourceImpl(sharedPreferences: get<SharedPreferences>()));
  gh.lazySingleton<ArbolesRemoteDataSourceImpl>(() =>
      ArbolesRemoteDataSourceImpl(
          client: get<Client>(), referencia: get<EsquemaDataDeSQL>()));
  gh.lazySingleton<ArbolesRepositorioImpl>(() => ArbolesRepositorioImpl(
        remoteDataSource: get<ArbolesRemoteDataSource>(),
        localDatasource: get<ArbolesLocalDataSource>(),
        netWorkInfo: get<NetworkInfo>(),
        sqlDataSource: get<FormLocalSourceSql>(),
      ));
  gh.lazySingleton<ComprobarIdNFCUseCase>(
      () => ComprobarIdNFCUseCase(get<ArbolesRepositorio>()));
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FormLocalSourceSqlImpl>(() => FormLocalSourceSqlImpl());
  gh.lazySingleton<GetArbolesCercanosUseCase>(
      () => GetArbolesCercanosUseCase(get<ArbolesRepositorio>()));
  gh.lazySingleton<GetCoordUseCase>(
      () => GetCoordUseCase(get<ArbolesRepositorio>()));
  gh.lazySingleton<GoogleSignIn>(() => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<IAuthFacade>(
      () => FirebaseAuthFacade(get<FirebaseAuth>(), get<GoogleSignIn>()));
  gh.lazySingleton<InputConverterIdNFCToStr>(() => InputConverterIdNFCToStr());
  gh.lazySingleton<InputConverterStrToLatLng>(
      () => InputConverterStrToLatLng());
  gh.lazySingleton<LeerIdNfcUseCase>(
      () => LeerIdNfcUseCase(get<ArbolesRepositorio>()));
  gh.lazySingleton<NetworkInfoImpl>(
      () => NetworkInfoImpl(get<DataConnectionChecker>()));
  gh.factory<SignInFormBloc>(() => SignInFormBloc(get<IAuthFacade>()));
  gh.factory<ArbolMapaBloc>(() => ArbolMapaBloc(
        arbolesCercanosUseCase: get<GetArbolesCercanosUseCase>(),
        comprobarIdNFCUseCase: get<ComprobarIdNFCUseCase>(),
        leerIdNfcUseCase: get<LeerIdNfcUseCase>(),
        getCoordUseCase: get<GetCoordUseCase>(),
        inputConverter: get<InputConverterStrToLatLng>(),
        inputConverterFromIdNFCToStr: get<InputConverterIdNFCToStr>(),
      ));
  gh.factory<AuthBloc>(() => AuthBloc(get<IAuthFacade>()));
  return get;
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
