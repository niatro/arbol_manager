import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import '../routes/router.gr.dart' as app_router;
import 'package:flutterapparbol/features/arbol/presentation/pages/sign_in_page.dart';
import 'package:flutterapparbol/features/arbol/presentation/splash/splash_page.dart';

import '../../../../injection_auto.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arboles',
        builder: ExtendedNavigator.builder(router: app_router.Router()),
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.green[800],
          accentColor: Colors.blueAccent,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
