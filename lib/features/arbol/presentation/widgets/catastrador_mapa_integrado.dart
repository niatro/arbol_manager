import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

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
              desplegandoArbolesCercanos: (s) {
                return s;
              },
              idNfcChequeado: (_) {},
              idNfcObtenido: (_) {},
              marcadorColocado: (_) {},
              mapaDesplegado: (x) {
                return x;
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
                  //ojo: aqui comienza google Maps
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
                      zoom: 19.00,
                    ),
                    onTap: (LatLng pos) {
                      print('los arboles pasados onTap ${s.arboles}');
                      context
                          .bloc<ArbolMapaBloc>()
                          .add(ArbolMapaEvent.onTapPantalla(
                            tapPosicion: pos,
                            arboles: s.arboles,
                            localizacion: s.latLong,
                          ));
                    },
                    markers: Set.of(_listaMarcadoresDeLosArboles(
                        s.arboles ?? new ArbolesEntity(listaArbolEntity: []))),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  );
                }, orElse: () {
                  return Text(
                      'Algo salio mal intentando mostrar el mapa $state');
                }),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () async {
                    print(
                        'En floatingActionButton el estado que entra es $state');
                    await context.bloc<ArbolMapaBloc>().add(
                          ArbolMapaEvent.getArbolesCercanosEvent(
                              state.maybeWhen(mapaDesplegado: (l, a, p) {
                                return "-33.39848065129757,-70.59791651315805";

                                // return l.latitude.toString() +
                                //     ',' +
                                //     l.longitude.toString();
                              }, orElse: () {
                                return "-33.37679954804514,-70.56944723226297";
                              }),
                              20),
                        );
                  },
                  label: Text('Cerca'),
                  icon: Icon(Icons.architecture_rounded),
                ));
          },
        ),
      ),
    );
  }

  List<Marker> _listaMarcadoresDeLosArboles(ArbolesEntity arboles) {
    final List<Marker> result = [];
    Uuid uuid = Uuid();
    if (arboles.listaArbolEntity != []) {
      arboles.listaArbolEntity.forEach((arbol) {
        result.add(Marker(
          markerId: MarkerId(uuid.v4()),
          position: arbol.geoReferenciaCapturaArbol,
        ));
      });
      return result;
    } else {
      return [
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(-33.45605108011955, -70.60064847178477),
        ),
      ];
    }
  }
}
