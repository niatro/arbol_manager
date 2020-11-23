import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class CatastradorMapa extends StatefulWidget {
  @override
  _CatastradorMapaState createState() => _CatastradorMapaState();
}

class _CatastradorMapaState extends State<CatastradorMapa> {
  Completer<GoogleMapController> _controller = Completer();
  bool _mapSatelite = false;
  GoogleMapController mapController;
  Map<MarkerId, Marker> _mapMarkers = Map();
  LatLng _localizacionActual;
  bool _mapToggle = false;
  ArbolesEntity arbolesEntity = ArbolesEntity(listaArbolEntity: []);
  Future<Position> position =
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  Marker _marcadorActual = Marker(markerId: MarkerId('0'));
  LatLng _coordenada;
  var uuid = Uuid();

  static const LatLng _center = const LatLng(-25.4157807, -54.6166762);

//  Widget _googleMapsWidget(ArbolMapaState state) {
//    return GoogleMap(
//      onTap: (LatLng location) {},
//      initialCameraPosition: CameraPosition(
//        target: _localizacionActual,
//        zoom: 14.4746,
//      ),
//      onMapCreated: _onMapCreated,
//      myLocationButtonEnabled: true,
//      initialCameraPosition: CameraPosition(
//        target: _center,
//        zoom: _zoom,
//      ),
//      markers: _markers,
//      onCameraMove: _onCameraMove,
//      mapType: MapType.normal,
//    );
//  }

  @override
  void initState() {
    super.initState();
//    arbolesEntity.listaArbolEntity.forEach((elemento) {
//      _markerFromListaArboles.add(elemento.markerArbol);
//    });

    position.then((currloc) {
      setState(() {
        _localizacionActual = LatLng(currloc.latitude, currloc.longitude);
        _mapToggle = true;
      });
    });
  }

  void _cuandoMapaEsCreado(controller) {
    setState(() {
      mapController = controller;
      _controller.complete(controller);
//      controller.setMapStyle(jsonEncode(MapStyleRetro));
    });
  }

  _posisionOnTap(LatLng pos) {
    ///Si el id es unico se seguira llenando la lista pero solo se presentará
    ///en pantalla un unico marcador
//    final markerId = MarkerId('1');
    final markerId = MarkerId(uuid.v1());
    final _infoWindow = InfoWindow(
        title: "${_mapMarkers.length}",
        snippet: "${pos.latitude}, ${pos.longitude}",
        onTap: () {
          print('Aqui puedo agregar algo');
        });
    final marker = Marker(
        markerId: markerId,
        position: pos,
        infoWindow: _infoWindow,
        draggable: true);

    /// Propiedad para adicionar marcadores
    setState(() {
      _mapMarkers[markerId] = marker;
      _marcadorActual = marker;
      _coordenada = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
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
            listener: (context, state) {})
      ],
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: const Text('Modulo Catastrador'),
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 80.0,
              width: MediaQuery.of(context).size.width,
              child: _mapToggle
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _localizacionActual,
                        zoom: 14.4746,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
//                        markers: Set.from(allMarkers),
//                markers: Set.of(allMarkersHisto),
                      onTap: _posisionOnTap,
                      mapType: _mapSatelite ? MapType.hybrid : MapType.normal,
                      compassEnabled: true,

                      ///Conecta el controlador del mapa con el mapa
                      onMapCreated: _cuandoMapaEsCreado,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}
