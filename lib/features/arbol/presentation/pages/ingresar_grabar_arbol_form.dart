import 'package:flutter/material.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/ingresar_grabar_form_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IngresarGrabarArbolPage extends StatelessWidget {
  final String idNfc;
  final LatLng posArbol;
  const IngresarGrabarArbolPage(
      {@required this.idNfc, @required this.posArbol, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingreso Arbol id'),
      ),
      body: IngresarGrabarArbolFormWidget(
        idUnico: idNfc,
        posicionArbol: posArbol,
      ),
    );
  }
}
