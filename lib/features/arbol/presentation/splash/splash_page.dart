import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
            initial: (_) {},
            authenticated: (_) {
              print('autentificado en splash');
              // ExtendedNavigator.of(context).replace(Routes.signInPage);

              // print('estoy autentificado: esto se imprime de splash_page.dart');
              ExtendedNavigator.of(context).replace(Routes.homeCatastrador);
              // ExtendedNavigator.of(context).pushHomeCatastrador();
            },
//              ExtendedNavigator.of(context).replace(Routes.notesOverviewPage),
            unauthenticated: (_) {
              print('NO autentificado en splash');
              ExtendedNavigator.of(context).replace(Routes.signInPage);
            });
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
