import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/ficha_arbol_page.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/home_catastrador.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/home_cliente.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/ingresar_grabar_arbol_form.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/password_perfil.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/sign_in_page.dart';
import 'package:flutterapparbol/features/arbol/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: PasswordPerfil),
    MaterialRoute(page: HomeCatastrador),
    MaterialRoute(page: IngresarGrabarArbolPage),
    MaterialRoute(page: HomeCliente),
    MaterialRoute(page: FichaArbolPage)
  ],
  generateNavigationHelperExtension: true,
)
class $Router {}
