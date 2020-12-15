import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/usuario_test.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/nfc/nfc_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/nfc_info_page.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/loading_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_auto.dart';

class InfoAccionArbolPie {
  final BuildContext context;
  final BitmapDescriptor iconMarkerResto;
  final ArbolMapaState state;
  final LatLng tapPos;
  final LatLng localizacion;
  final ArbolesEntity arboles;
  InfoAccionArbolPie(
      {@required this.context,
      this.iconMarkerResto,
      this.state,
      this.tapPos,
      this.localizacion,
      this.arboles});

  void mostrarFichaArbol(BuildContext context,
      [ArbolMapaState state,
      LatLng tapPos,
      LatLng localizacion,
      ArbolesEntity arboles]) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            height: 100,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Row(
              children: [
                BlocProvider<NfcBloc>(
                  create: (context) => getIt<NfcBloc>(),
                  child: Expanded(
                    child: BlocConsumer<NfcBloc, NfcState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return state.maybeMap((value) {
                            if (value.nfcEntity.idNfc != null) {
                              if (value.estaRegistrado == false &&
                                  value.showErrorMessages == false) {
                                print(value.nfcEntity.idNfc);
                                return RaisedButton(
                                  onPressed: () {
                                    return context.bloc<NfcBloc>().add(
                                        NfcEvent.verificadoIdNfc(
                                            value.nfcEntity.idNfc));

                                    //TODO: mostrar otro showModalBottom
                                  },
                                  child: Text(
                                    'VERIFICA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  color: Colors.red[200],
                                );
                              } else if (value.estaRegistrado == false &&
                                  value.showErrorMessages == true) {
                                return RaisedButton(
                                  onPressed: () {
                                    ExtendedNavigator.of(context)
                                        .pushIngresarGrabarArbolPage(
                                            idNfc: value.nfcEntity.idNfc,
                                            posArbol: tapPos);
                                  },
                                  child: Text(
                                    'AGREGA CON CHIP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                  color: Colors.red[200],
                                );
                              } else {
                                return RaisedButton(
                                  onPressed: () {
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return new NfcInfo(
                                    //     nfcEntity: value.nfcEntity,
                                    //     state: state,
                                    //   );
                                    // }));

                                    //TODO: mostrar otro showModalBottom
                                  },
                                  child: Text(
                                    'EXISTE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                  color: Colors.red[200],
                                );
                              }
                            } else {
                              print(value.nfcEntity.idNfc);
                              return RaisedButton(
                                onPressed: () {
                                  return context
                                      .bloc<NfcBloc>()
                                      .add(NfcEvent.leidoNfc());

                                  //TODO: mostrar otro showModalBottom
                                },
                                child: Text(
                                  'LEE CHIP ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9,
                                  ),
                                ),
                                color: Colors.lightBlue,
                              );
                            }
                          }, loadingNfcState: (_) {
                            return LoadingWhite();
                          }, orElse: () {
                            return RaisedButton(
                              onPressed: () {
                                return context
                                    .bloc<NfcBloc>()
                                    .add(NfcEvent.leidoNfc());

                                //TODO: mostrar otro showModalBottom
                              },
                              child: Text(
                                'LEE CHIP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                ),
                              ),
                              color: Colors.lightBlue,
                            );
                          });
                        }),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      //TODO: ir a agregar arbol form
                    },
                    child: const Text(
                      'AGREGA SIN CHIP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      context.bloc<ArbolMapaBloc>().add(
                            ArbolMapaEvent.getArbolesCercanosEvent(
                              state.maybeWhen(
                                  mapaDesplegado: (l, a, p, u, i, ir) {
                                return tapPos.latitude.toString() +
                                    ',' +
                                    tapPos.longitude.toString();
                              }, orElse: () {
                                return "-33.37679954804514,-70.56944723226297";
                              }),
                              50,
                              iconMarkerResto,
                            ),
                          );
                    },
                    child: const Text(
                      'ARBOLES CERCA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
