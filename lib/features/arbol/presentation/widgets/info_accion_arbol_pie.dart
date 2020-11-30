import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/usuario_test.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class InfoAccionArbolPie {
  final BuildContext context;
  final ArbolMapaState state;
  final LatLng tapPos;
  final LatLng localizacion;
  final ArbolesEntity arboles;
  InfoAccionArbolPie(
      {@required this.context,
      this.state,
      this.tapPos,
      this.localizacion,
      this.arboles});

  void mostrarFichaArbol(BuildContext context,
      [ArbolMapaState state,
      LatLng tapPos,
      LatLng localizacion,
      ArbolesEntity arboles]) {
    print(' En MOSTRARFICHAARBOL el CONTEXT que entra es $context');
    print(' En MOSTRARFICHAARBOL el ESTADO que entra es $state');
    showModalBottomSheet(
        context: context,
        builder: (_) {
          print(
              ' En MOSTRARFICHAARBOL DESPUES CONSTRUIR CONTEXTO el CONTEXT que entra es $context');
          print(
              ' En MOSTRARFICHAARBOL DESPUES CONSTRUIR CONTEXTO  el ESTADO que entra es $state');
          return Container(
            height: 100,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      print(' En BOTON CERCA el CONTEXT que entra es $context');
                      context.bloc<ArbolMapaBloc>().add(
                            ArbolMapaEvent.leerIdNfConTelefonoEvent(
                                latLng: state.maybeMap(
                                    mapaDesplegado: (_) {
                                      return localizacion;
                                    },
                                    orElse: null),
                                arboles: arboles,
                                tapPosition: tapPos,
                                usuario: usuarioTest),
                          );

                      //TODO: mostrar otro showModalBottom
                    },
                    child: const Text(
                      'AGREGA CON NFC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      //TODO: ir a agregar arbol form
                    },
                    child: const Text(
                      'AGREGA SIN NFC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      print(' En BOTON CERCA el CONTEXT que entra es $context');
                      print(' En BOTON CERCA el ESTADO que entra es $state');
                      print(tapPos);

                      context.bloc<ArbolMapaBloc>().add(
                            ArbolMapaEvent.getArbolesCercanosEvent(
                                state.maybeWhen(mapaDesplegado: (l, a, p, u) {
                                  return tapPos.latitude.toString() +
                                      ',' +
                                      tapPos.longitude.toString();
                                }, orElse: () {
                                  return "-33.37679954804514,-70.56944723226297";
                                }),
                                50),
                          );
                    },
                    child: const Text(
                      'ARBOLES CERCA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
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
