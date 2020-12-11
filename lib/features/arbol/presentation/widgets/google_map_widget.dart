import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/lista_marcadores_de_arboles_creacion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

class GoogleMapWidget extends StatelessWidget {
  final ArbolMapaState state;
  final MapaDesplegadoState s;
  final BuildContext context;
  final BitmapDescriptor customIcon;
  final UserEntity usuario;

  const GoogleMapWidget({
    Key key,
    @required this.state,
    @required this.s,
    @required this.context,
    @required this.customIcon,
    @required this.usuario,
  }) : super(key: key);

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
    print('llego al widget final $usuario');
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
      onTap: (LatLng pos) async {
        final Uint8List markerIcon =
            await getBytesFromAsset('assets/images/tree_256.png', 200);
        var icon = BitmapDescriptor.fromBytes(markerIcon);
        final Uint8List markerIconResto =
            await getBytesFromAsset('assets/images/arbolito_128.png', 100);
        var iconResto = BitmapDescriptor.fromBytes(markerIconResto);

        // var icon = await getIcons();
        context.bloc<ArbolMapaBloc>().add(ArbolMapaEvent.onTapPantalla(
              tapPosicion: pos,
              arboles: s.arboles,
              localizacion: s.latLong,
              markerIcon: icon,
              markerIconResto: iconResto,
            ));
      },
      markers: Set.of(
        ListaMarcadoresDeArbolesCreacion.desarrollo(
          arboles: s.arboles ?? new ArbolesEntity(listaArbolEntity: []),
          icono: s.markerIcon,
          iconoResto: s.markerIconResto,
          context: this.context,
          state: s,
          tapPos: s.tapPosition,
          localizacion: s.latLong,
        ).listaMarcadores,
      ),
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
