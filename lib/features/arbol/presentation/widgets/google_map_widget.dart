import 'package:flutter/material.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/lista_marcadores_de_arboles_creacion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleMapWidget extends StatelessWidget {
  final ArbolMapaState state;
  final MapaDesplegadoState s;
  final BuildContext context;

  const GoogleMapWidget({
    Key key,
    @required this.state,
    @required this.s,
    @required this.context,
    @required this.customIcon,
  }) : super(key: key);

  final BitmapDescriptor customIcon;

  @override
  Widget build(BuildContext context) {
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
        context.bloc<ArbolMapaBloc>().add(ArbolMapaEvent.onTapPantalla(
              tapPosicion: pos,
              arboles: s.arboles,
              localizacion: s.latLong,
            ));
      },
      markers: Set.of(
        ListaMarcadoresDeArbolesCreacion.desarrollo(
          arboles: s.arboles ?? new ArbolesEntity(listaArbolEntity: []),
          icono: customIcon,
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
