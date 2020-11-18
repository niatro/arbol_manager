import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/sign_in_page.dart';
import 'package:flutterapparbol/features/arbol/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
  ],
  generateNavigationHelperExtension: true,
)
class $Router {}
