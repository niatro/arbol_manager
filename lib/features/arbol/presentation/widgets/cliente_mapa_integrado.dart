import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/nfc/nfc_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/google_map_widget.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/loading_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../../../injection_auto.dart';

class ClienteMapaIntegrado extends StatelessWidget {
  final UserEntity usuario;
  ClienteMapaIntegrado({@required this.usuario});
  BitmapDescriptor customIcon;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArbolMapaBloc>(
          create: (context) =>
              getIt<ArbolMapaBloc>()..add(ArbolMapaEvent.getCoordenadasEvent()),
        ),
        BlocProvider<NfcBloc>(
          create: (context) => getIt<NfcBloc>(),
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
          BlocListener<ArbolMapaBloc, ArbolMapaState>(
            listener: (context, state) {
              state.maybeMap(orElse: () {});
            },
          )
        ],
        child: BlocConsumer<ArbolMapaBloc, ArbolMapaState>(
          listener: (context, state) {
            state.maybeMap(
              coordenadasObtenidas: (_) {},
              desplegandoArbolesCercanos: (s) {
                return s;
              },
              mapaDesplegado: (x) {
                return x;
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Modulo Municipal'),
                  leading: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
                    },
                  ),
                ),
                body: state.maybeMap(initial: (_) {
                  return LoadingWhite();
                }, mapaDesplegado: (s) {
                  return GoogleMapWidget(
                    state: state,
                    s: s,
                    context: context,
                    customIcon: customIcon,
                    usuario: usuario,
                  );
                }, loading: (_) {
                  return LoadingWhite();
                }, orElse: () {
                  return Text(
                      'Algo salio mal intentando mostrar el mapa $state');
                }),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    final Uint8List markerIconResto = await getBytesFromAsset(
                        'assets/images/arbolito_128.png', 100);
                    var iconResto = BitmapDescriptor.fromBytes(markerIconResto);
                    await context.bloc<ArbolMapaBloc>().add(
                          ArbolMapaEvent.getArbolesCercanosEvent(
                              state.maybeWhen(
                                  mapaDesplegado: (l, a, p, u, i, ir) {
                                return "-33.39848065129757,-70.59791651315805";
                              }, orElse: () {
                                return "-33.37679954804514,-70.56944723226297";
                              }),
                              50,
                              iconResto),
                        );
                  },
                  child: Icon(Icons.add),
                ));
          },
        ),
      ),
    );
  }


}