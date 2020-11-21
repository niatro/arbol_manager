import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';

import '../../../../injection_container.dart';

class HomeCatastrador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ArbolesEntityBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                unauthenticated: (_) =>
                    ExtendedNavigator.of(context).replace(Routes.signInPage),
                orElse: () {},
              );
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.lightGreen,
          appBar: AppBar(
            title: const Text('Arbolardo'),
            leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
          ),
          body: Container(
            child: Center(
              child: Text('Catastrador'),
            ),
          ),
        ),
      ),
    );
  }
}
