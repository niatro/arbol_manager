// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/user_entity.dart';
import '../pages/home_catastrador.dart';
import '../pages/home_cliente.dart';
import '../pages/ingresar_grabar_arbol_form.dart';
import '../pages/password_perfil.dart';
import '../pages/sign_in_page.dart';
import '../splash/splash_page.dart';

class Routes {
  static const String splashPage = '/';
  static const String signInPage = '/sign-in-page';
  static const String passwordPerfil = '/password-perfil';
  static const String homeCatastrador = '/home-catastrador';
  static const String ingresarGrabarArbolPage = '/ingresar-grabar-arbol-page';
  static const String homeCliente = '/home-cliente';
  static const all = <String>{
    splashPage,
    signInPage,
    passwordPerfil,
    homeCatastrador,
    ingresarGrabarArbolPage,
    homeCliente,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.signInPage, page: SignInPage),
    RouteDef(Routes.passwordPerfil, page: PasswordPerfil),
    RouteDef(Routes.homeCatastrador, page: HomeCatastrador),
    RouteDef(Routes.ingresarGrabarArbolPage, page: IngresarGrabarArbolPage),
    RouteDef(Routes.homeCliente, page: HomeCliente),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashPage(),
        settings: data,
      );
    },
    SignInPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInPage(),
        settings: data,
      );
    },
    PasswordPerfil: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PasswordPerfil(),
        settings: data,
      );
    },
    HomeCatastrador: (data) {
      final args = data.getArgs<HomeCatastradorArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeCatastrador(usuario: args.usuario),
        settings: data,
      );
    },
    IngresarGrabarArbolPage: (data) {
      final args =
          data.getArgs<IngresarGrabarArbolPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => IngresarGrabarArbolPage(
          idNfc: args.idNfc,
          posArbol: args.posArbol,
          key: args.key,
        ),
        settings: data,
      );
    },
    HomeCliente: (data) {
      final args = data.getArgs<HomeClienteArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeCliente(usuario: args.usuario),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushSplashPage() => push<dynamic>(Routes.splashPage);

  Future<dynamic> pushSignInPage() => push<dynamic>(Routes.signInPage);

  Future<dynamic> pushPasswordPerfil() => push<dynamic>(Routes.passwordPerfil);

  Future<dynamic> pushHomeCatastrador({
    @required UserEntity usuario,
  }) =>
      push<dynamic>(
        Routes.homeCatastrador,
        arguments: HomeCatastradorArguments(usuario: usuario),
      );

  Future<dynamic> pushIngresarGrabarArbolPage({
    @required String idNfc,
    @required LatLng posArbol,
    Key key,
  }) =>
      push<dynamic>(
        Routes.ingresarGrabarArbolPage,
        arguments: IngresarGrabarArbolPageArguments(
            idNfc: idNfc, posArbol: posArbol, key: key),
      );

  Future<dynamic> pushHomeCliente({
    @required UserEntity usuario,
  }) =>
      push<dynamic>(
        Routes.homeCliente,
        arguments: HomeClienteArguments(usuario: usuario),
      );
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeCatastrador arguments holder class
class HomeCatastradorArguments {
  final UserEntity usuario;
  HomeCatastradorArguments({@required this.usuario});
}

/// IngresarGrabarArbolPage arguments holder class
class IngresarGrabarArbolPageArguments {
  final String idNfc;
  final LatLng posArbol;
  final Key key;
  IngresarGrabarArbolPageArguments(
      {@required this.idNfc, @required this.posArbol, this.key});
}

/// HomeCliente arguments holder class
class HomeClienteArguments {
  final UserEntity usuario;
  HomeClienteArguments({@required this.usuario});
}
