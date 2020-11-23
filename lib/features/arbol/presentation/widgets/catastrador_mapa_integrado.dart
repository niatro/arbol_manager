import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../injection_auto.dart';

class CatastradorMapaIntegrado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArbolMapaBloc>(
          create: (context) =>
              getIt<ArbolMapaBloc>()..add(ArbolMapaEvent.getCoordenadasEvent()),
        )
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
        child: BlocConsumer<ArbolMapaBloc, ArbolMapaState>(
          listener: (context, state) {
            state.maybeMap(
              coordenadasObtenidas: (_) {},
              arbolesCercanosObtenidos: (_) {},
              idNfcChequeado: (_) {},
              idNfcObtenido: (_) {},
              marcadorColocado: (_) {},
              mapaDesplegado: (s) {
                return s;
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Modulo Catastrador'),
                  leading: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
                    },
                  ),
                ),
                body: state.maybeMap(initial: (_) {
                  return CircularProgressIndicator();
                }, mapaDesplegado: (s) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: state.maybeMap(
                        mapaDesplegado: (s) {
                          return s.latLong;
                        },
                        orElse: () {
                          return LatLng(-33.39795292537557, -70.60091244581768);
                        },
                      ),
                      zoom: 18.00,
                    ),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  );
                }, orElse: () {
                  return Text('Algo salio mal');
                }));
          },
        ),
      ),
    );
  }
}
