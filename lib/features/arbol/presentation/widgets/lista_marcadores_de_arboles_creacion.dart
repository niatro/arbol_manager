import 'package:flutter/material.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/info_accion_arbol_pie.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class ListaMarcadoresDeArbolesCreacion {
  List<Marker> listaMarcadores;
  ListaMarcadoresDeArbolesCreacion({@required this.listaMarcadores});

  factory ListaMarcadoresDeArbolesCreacion.desarrollo(
      {ArbolesEntity arboles,
      BitmapDescriptor icono,
      BuildContext context,
      ArbolMapaState state,
      LatLng tapPos,
      LatLng localizacion}) {
    final List<Marker> result = [];
    int sizeLista = arboles.listaArbolEntity.length;
    Uuid uuid = Uuid();

    final _infoWindow = InfoWindow(
        title: "Acciones",
        onTap: () {
          new InfoAccionArbolPie(
                  context: context,
                  state: state,
                  tapPos: tapPos,
                  localizacion: localizacion,
                  arboles: arboles)
              .mostrarFichaArbol(context, state, tapPos, localizacion, arboles);
        });

    if (arboles.listaArbolEntity != []) {
      if (arboles.listaArbolEntity.length == 1) {
        return ListaMarcadoresDeArbolesCreacion(listaMarcadores: [
          Marker(
            markerId: MarkerId(uuid.v4()),
            position: arboles.listaArbolEntity[0].geoReferenciaCapturaArbol,
            draggable: true,
            // icon: customIcon
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: _infoWindow,
          ),
        ]);
      } else {
        if (arboles.listaArbolEntity.length > 1) {
          if (arboles.listaArbolEntity[sizeLista - 1].idArbol ==
              arboles.listaArbolEntity[sizeLista - 2].idArbol) {
            arboles.listaArbolEntity
                .removeAt(arboles.listaArbolEntity.length - 2);
          }
        }
        for (ArbolEntity arbol in arboles.listaArbolEntity) {
          if (arbol.idArbol == 0) {
            result.add(Marker(
              markerId: MarkerId(uuid.v4()),
              position: arbol.geoReferenciaCapturaArbol,
              draggable: true,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              infoWindow: _infoWindow,
            ));
          } else {
            result.add(Marker(
              markerId: MarkerId(uuid.v4()),
              position: arbol.geoReferenciaCapturaArbol,
              infoWindow: InfoWindow(
                title: arbol.idArbol.toString(),
                snippet: arbol.especieArbol,
                onTap: () {},
              ),
            ));
          }
        }
        return ListaMarcadoresDeArbolesCreacion(listaMarcadores: result);
      }
      ;
    } else {
      return ListaMarcadoresDeArbolesCreacion(listaMarcadores: [
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(-33.45605108011955, -70.60064847178477),
        ),
      ]);
    }
  }
}
