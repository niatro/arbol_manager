import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/core/constants/lista_de_arboles_test.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/nfc/nfc_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/google_mapa_cliente_widget.dart';
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
                  title: const Text('Vitacura'),
                  leading: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.map_outlined),
                        onPressed: () async {
                          final Uint8List _markerIcon = await getBytesFromAsset(
                              'assets/images/tree_256.png', 200);
                          var _icon = BitmapDescriptor.fromBytes(_markerIcon);
                          await context
                              .bloc<ArbolMapaBloc>()
                              .add(ArbolMapaEvent.cambiarMapa(
                                localizacion: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return l;
                                }, orElse: () {
                                  return LatLng(
                                      -33.37679954804514, -70.56944723226297);
                                }),
                                cambiar: true,
                                markerIcon: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return i;
                                }, orElse: () {
                                  return customIcon;
                                }),
                                markerIconResto: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return ir;
                                }, orElse: () {
                                  return customIcon;
                                }),
                                arboles: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return a;
                                }, orElse: () {
                                  return arbolesEntityTest;
                                }),
                              ));
                        }),
                    IconButton(
                        icon: Icon(Icons.satellite_outlined),
                        onPressed: () async {
                          final Uint8List _markerIcon = await getBytesFromAsset(
                              'assets/images/tree_256.png', 200);
                          var _icon = BitmapDescriptor.fromBytes(_markerIcon);
                          await context
                              .bloc<ArbolMapaBloc>()
                              .add(ArbolMapaEvent.cambiarMapa(
                                localizacion: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return l;
                                }, orElse: () {
                                  return LatLng(
                                      -33.37679954804514, -70.56944723226297);
                                }),
                                cambiar: false,
                                markerIcon: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return i;
                                }, orElse: () {
                                  return customIcon;
                                }),
                                markerIconResto: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return ir;
                                }, orElse: () {
                                  return customIcon;
                                }),
                                arboles: state.maybeWhen(mapaDesplegado:
                                    (l, a, p, u, i, ir, mt, ver) {
                                  return a;
                                }, orElse: () {
                                  return arbolesEntityTest;
                                }),
                              ));
                        }),
                  ],
                ),
                body: state.maybeMap(initial: (_) {
                  return LoadingWhite();
                }, mapaDesplegado: (s) {
                  return GoogleMapaClienteWidget(
                    state: state,
                    s: s,
                    context: context,
                    customIcon: customIcon,
                    usuario: usuario,
                    mapType: s.mapType,
                  );
                }, loading: (_) {
                  return LoadingWhite();
                }, orElse: () {
                  return Text(
                      'Algo salio mal intentando mostrar el mapa $state');
                }),
                floatingActionButton: Row(
                  children: [
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () async {
                            final Uint8List markerIconResto =
                                await getBytesFromAsset(
                                    'assets/images/arbolito_128.png', 100);
                            var _iconMarkerResto =
                                BitmapDescriptor.fromBytes(markerIconResto);
                            await context.bloc<ArbolMapaBloc>().add(
                                  ArbolMapaEvent.getArbolesCercanosEvent(
                                      state.maybeWhen(mapaDesplegado:
                                          (l, a, p, u, i, ir, mt, ver) {
                                        print(p);
                                        print(l);
                                        if (p != null) {
                                          return "${p.latitude},${p.longitude}";
                                        } else {
                                          return "${l.latitude},${l.longitude}";
                                        }
                                      }, orElse: () {
                                        return "-33.37679954804514,-70.56944723226297";
                                      }),
                                      50,
                                      _iconMarkerResto),
                                );
                          },
                        ),
                        const SizedBox(height: 8),
                        BlocProvider<NfcBloc>(
                          create: (context) => getIt<NfcBloc>(),
                          child: BlocConsumer<NfcBloc, NfcState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return state.maybeMap((value) {
                                if (value.arbol != null) {
                                  ExtendedNavigator.of(context)
                                      .pushFichaArbolPage(
                                          arbol: value
                                              .arbol.listaArbolEntity.last);
                                } else if (value.showErrorMessages == true) {
                                  // FlushbarHelper.createError(
                                  //         message: 'no registrado')
                                  //     .show(context);
                                }
                                return FloatingActionButton(
                                  heroTag: null,
                                  onPressed: () {
                                    return context.bloc<NfcBloc>().add(
                                        NfcEvent.leerVerificarConseguir(
                                            usuario));
                                  },
                                  child: Icon(Icons.wifi),
                                );
                              }, loadingNfcState: (_) {
                                return LoadingPulse();
                              }, orElse: () {});
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
