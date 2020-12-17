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

class InfoAccionArbolPieCliente {
  final BuildContext context;
  final BitmapDescriptor iconMarkerResto;
  final ArbolMapaState state;
  final LatLng tapPos;
  final LatLng localizacion;
  final ArbolesEntity arboles;
  InfoAccionArbolPieCliente(
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
                const SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      //TODO: ir a agregar arbol form
                    },
                    child: const Text(
                      'NOTIFICAR ARBOL A CATASTRAR',
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
                    onPressed: () {},
                    child: const Text(
                      'NOTIFICAR ARBOL SIN CHIP',
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
