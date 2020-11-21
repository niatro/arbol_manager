import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutterapparbol/core/usecases/usecase.dart';

import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import '../routes/router.gr.dart' as app_router;
import 'package:flutterapparbol/injection_container.dart';

import '../../../../injection_auto.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bloc.MultiBlocProvider(
      providers: [
        bloc.BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arboles',
        builder: ExtendedNavigator.builder(
          router: app_router.Router(),
        ),
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
