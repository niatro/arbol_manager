import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/local_data_estructuras.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/loading_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class IngresarGrabarArbolFormWidget extends StatefulWidget {
  final String idUnico;
  final LatLng posicionArbol;
  IngresarGrabarArbolFormWidget({
    @required this.idUnico,
    @required this.posicionArbol,
    Key key,
  }) : super(key: key);

  @override
  _IngresarGrabarArbolFormWidgetState createState() =>
      _IngresarGrabarArbolFormWidgetState();
}

class _IngresarGrabarArbolFormWidgetState
    extends State<IngresarGrabarArbolFormWidget> {
  final _formKey = GlobalKey<FormState>();

  ArbolesEntity arbolesEntity = new ArbolesEntity(listaArbolEntity: []);
  ArbolEntity _arbol;

  String _guiArbol;
  int _idArbol;
  List<dynamic> _idNfcHistoria = [];
  String _clienteArbol;
  String _zonaArbol;
  String _calleArbol;
  int _nCalleArbol;
  String _esquinaCalleArbol;
  String _especieArbol;
  int _diametroTroncoArbolCm;
  double _diametroCopaNsArbolMt;
  double _diametroCopaEoArbolMt;
  double _alturaArbolArbolMt;
  double _alturaCopaArbolMt;
  String _estadoGeneralArbol;
  String _estadoSanitarioArbol;
  Enfermedad _enfermedad;
  String _agentePatogeno;
  String _lugarPlaga;
  String _sintoma;
  String _inclinacionTroncoArbol;
  String _orientacionInclinacionArbol;
  String _obsArbolHistoria;
  String _accionObsArbol;
  String _segundaAccionObsArbol;
  String _terceraAccionObsArbol;
  LatLng _geoReferenciaCapturaArbol;
  String _nombreUsuarioCreacionArbol;
  String _usuarioModificaArbol;
  DateTime fechaCreacionArbol;
  DateTime _fechaUltimaModArbol;
  bool _alertaArbol = false;
  bool _revisionArbol = false;
  // List<dynamic> _fotosArbol;
  // List<dynamic> _fotosEnfermedad;
  int _countFotosArbol = 0;
  int _countFotosEnfermedad = 0;

  FormLocalSourceSqlImpl databaseHelper = FormLocalSourceSqlImpl();
  EsquemaDataDeSQL referencia = EsquemaDataDeSQL();
  http.Client client = http.Client();
  List<String> _fotosArbolPath = [];
  List<File> _fotosArbolFile;
  List<String> _fotosEnfermedadPath = [];
  List<File> _fotosEnfermedadFile;
  final picker = ImagePicker();
  Uuid gui = Uuid();
  bool _llenarEnfermedades = false;

  Future<void> tomarImagenArbol(ImagePicker picker) async {
    var pickedImage = await picker.getImage(source: ImageSource.camera);
    String path = pickedImage.path;
    setState(() {
      _fotosArbolPath.add(path);
      if (_fotosArbolPath.length > 3) {
        _fotosArbolPath.removeAt(0);
      }
    });
  }

  Future<void> tomarImagenEnfermedad(ImagePicker picker) async {
    var pickedImage = await picker.getImage(source: ImageSource.camera);
    String path = pickedImage.path;

    setState(() {
      _fotosEnfermedadPath.add(path);
      if (_fotosEnfermedadPath.length > 1) {
        _fotosEnfermedadPath.removeAt(0);
      }
    });
  }

  Future<List<Map<String, dynamic>>> campo(
      {@required nombreTabla, @required campoOrdenador}) async {
    List _result = [];
    _result = await databaseHelper.getFilasMapList(
      nombreTabla: nombreTabla,
      campoOrdenador: campoOrdenador,
    );
    return _result;
  }

  Future<List<Map<String, dynamic>>> campoWhere({
    @required nombreTabla,
    @required campoOrdenador,
    @required campoRestringido,
    @required valorRestrictor,
  }) async {
    List _result = [];
    _result = await databaseHelper.getFilasMapListWhere(
      nombreTabla: nombreTabla,
      campoOrdenador: campoOrdenador,
      campoRestringido: campoRestringido,
      valorRestrictor: valorRestrictor,
    );
    return _result;
  }

  Widget _buildClientesDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.cliente.nombreTabla,
        campoOrdenador: referencia.cliente.clienteNombre,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Selecciona cliente'),
                      value: _clienteArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String valor = item['clienteNombre'];
                        return DropdownMenuItem(
                          child: Text(valor),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _clienteArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildZonaDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.zona.nombreTabla,
        campoOrdenador: referencia.zona.zonaNombre,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Selector de zona'),
                      value: _zonaArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['zonaNombre'];
                        String valor = item['zonaNombre'] +
                            "," +
                            item['zonaId'].toString();
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _zonaArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildCallesDropDown() {
    return FutureBuilder(
      future: campoWhere(
        nombreTabla: referencia.calle.nombreTabla,
        campoOrdenador: referencia.calle.calleNombre,
        campoRestringido: referencia.calle.calleZonaId,
        valorRestrictor: _zonaArbol == null ? "1" : _zonaArbol.split(",")[1],
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Selecciona calle'),
                      value: _calleArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        // print('${item['calleTipo']}  / ${item['calleNombre']}');

                        String texto =
                            item['calleTipo'] + " / " + item['calleNombre'];
                        String valor = item['calleNombre'] +
                            "," +
                            item['calleZonaId'].toString() +
                            item['calleId'].toString();
                        return DropdownMenuItem(
                          child: Text(texto),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _calleArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildCallesEsquinaDropDown() {
    return FutureBuilder(
      future: campoWhere(
        nombreTabla: referencia.calle.nombreTabla,
        campoOrdenador: referencia.calle.calleNombre,
        campoRestringido: referencia.calle.calleZonaId,
        valorRestrictor: _zonaArbol == null ? "1" : _zonaArbol.split(",")[1],
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Selecciona calle Esquina'),
                      value: _esquinaCalleArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String texto =
                            item['calleTipo'] + " / " + item['calleNombre'];
                        String valor = item['calleNombre'] +
                            "," +
                            item['calleOrigenId'].toString();
                        return DropdownMenuItem(
                          child: Text(texto),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _esquinaCalleArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildNumeroDireccionTextInput() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Agrega solo el numero",
          labelText: "Numero dirección",
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black87,
          )),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (!RegExp(r"^\d+$").hasMatch(value)) {
          return 'Ingresar un numero valido';
        } else if (value.isEmpty) {
          return 'Debe ingresar un valor';
        }
        return null;
      },
      onSaved: (String valorNuevo) {
        setState(() {
          _nCalleArbol = int.parse(valorNuevo);
        });
      },
    );
  }

  Widget _buildEspecieDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.especie.nombreTabla,
        campoOrdenador: referencia.especie.especieOrden,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Selector de especie'),
                      value: _especieArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['especieNombreCientifico'] +
                            " / " +
                            item['especieNombreComun'];
                        String valor = item['especieNombreCientifico'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _especieArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildDiametroTroncoCmTextInput() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Agrega solo el numero",
          labelText: "DAP (cm)",
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black87,
          )),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (!RegExp(r"^\d+$").hasMatch(value)) {
          return 'Ingresar un numero valido';
        } else if (value.isEmpty) {
          return 'Debe ingresar un valor';
        }
        return null;
      },
      onSaved: (String valorNuevo) {
        setState(() {
          _diametroTroncoArbolCm = int.parse(valorNuevo);
        });
      },
    );
  }

  Widget _buildAlturaArbolMtTextInput() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Agrega solo el numero",
          labelText: "Altura (mt)",
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black87,
          )),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (!RegExp(r"^[0-9]+(\.[0-9]{1,2})?$").hasMatch(value)) {
          return 'Ingresar un numero valido';
        } else if (value.isEmpty) {
          return 'Debe ingresar un valor';
        }
        return null;
      },
      onSaved: (String valorNuevo) {
        setState(() {
          _alturaArbolArbolMt = double.parse(valorNuevo);
        });
      },
    );
  }

  Widget _buildAlturaCopaArbolMtTextInput() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Agrega solo el numero",
          labelText: "Altura inicio copa (mt)",
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black87,
          )),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (!RegExp(r"^[0-9]+(\.[0-9]{1,2})?$").hasMatch(value)) {
          return 'Ingresar un numero valido';
        } else if (value.isEmpty) {
          return 'Debe ingresar un valor';
        }
        return null;
      },
      onSaved: (String valorNuevo) {
        setState(() {
          _alturaCopaArbolMt = double.parse(valorNuevo);
        });
      },
    );
  }

  Widget _buildDiametroCopaNsMtTextInput() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Agrega solo el numero",
          labelText: "Diametro copa NS (mt)",
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black87,
          )),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (!RegExp(r"^[0-9]+(\.[0-9]{1,2})?$").hasMatch(value)) {
          return 'Ingresar un numero valido';
        } else if (value.isEmpty) {
          return 'Debe ingresar un valor';
        }
        return null;
      },
      onSaved: (String valorNuevo) {
        setState(() {
          _diametroCopaNsArbolMt = double.parse(valorNuevo);
        });
      },
    );
  }

  Widget _buildDiametroCopaEoMtTextInput() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Agrega solo el numero",
          labelText: "Diametro copa EO (mt)",
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black87,
          )),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (!RegExp(r"^[0-9]+(\.[0-9]{1,2})?$").hasMatch(value)) {
          return 'Ingresar un numero valido';
        } else if (value.isEmpty) {
          return 'Debe ingresar un valor';
        }
        return null;
      },
      onSaved: (String valorNuevo) {
        setState(() {
          _diametroCopaEoArbolMt = double.parse(valorNuevo);
        });
      },
    );
  }

  Widget _buildEstadoGeneralDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.estadoGeneral.nombreTabla,
        campoOrdenador: referencia.estadoGeneral.estadoGeneralDesc,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Estado general'),
                      value: _estadoGeneralArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['estadoGeneralDesc'];
                        String valor = item['estadoGeneralDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _estadoGeneralArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildEstadoSanitarioDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.estadoSanitario.nombreTabla,
        campoOrdenador: referencia.estadoSanitario.estadoSanitarioOrigenId,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Estado sanitario'),
                      value: _estadoSanitarioArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['estadoSanitarioDesc'];
                        String valor = item['estadoSanitarioDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          if (valorNuevo != "Sano") {
                            _llenarEnfermedades = true;
                          }
                          _estadoSanitarioArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildInclinacionArbolDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.inclinacionTronco.nombreTabla,
        campoOrdenador: referencia.inclinacionTronco.inclinacionTroncoDesc,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Inclinacion tronco'),
                      value: _inclinacionTroncoArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['inclinacionTroncoDesc'];
                        String valor = item['inclinacionTroncoDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _inclinacionTroncoArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildOrientacionInclinacionDropDown() {
    return FutureBuilder(
      future: campo(
          nombreTabla: referencia.orientacionInclinacion.nombreTabla,
          campoOrdenador:
              referencia.orientacionInclinacion.orientacionInclinacionDesc),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) =>
                          value == null ? 'Campo obligatorio' : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Orientacion inclinación'),
                      value: _orientacionInclinacionArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['orientacionInclinacionDesc'];
                        String valor = item['orientacionInclinacionDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _orientacionInclinacionArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildObservacionArbolTextInput() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Agrega la observacion si es relevante",
          labelText: "Observaciones",
          icon: Icon(
            FontAwesomeIcons.locationArrow,
            color: Colors.black87,
          )),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (!RegExp(r"^\W*(?:\w+(?:\W+|$)){0,50}$").hasMatch(value)) {
          return 'No ingresar mas de 50 palabras';
        }
        return null;
      },
      onSaved: (String valorNuevo) {
        setState(() {
          _obsArbolHistoria = valorNuevo;
        });
      },
    );
  }

  Widget _buildPrimeraAccionObsDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.accionObs.nombreTabla,
        campoOrdenador: referencia.accionObs.accionObsOrden,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButton<String>(
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Accion principal'),
                      value: _accionObsArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['accionObsDesc'];
                        String valor = item['accionObsDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _accionObsArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildSegundaAccionObsDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.accionObs.nombreTabla,
        campoOrdenador: referencia.accionObs.accionObsOrden,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButton<String>(
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Accion secundaria'),
                      value: _segundaAccionObsArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['accionObsDesc'];
                        String valor = item['accionObsDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _segundaAccionObsArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildTerceraAccionObsDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.accionObs.nombreTabla,
        campoOrdenador: referencia.accionObs.accionObsOrden,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButton<String>(
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Accion terciaria'),
                      value: _terceraAccionObsArbol,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['accionObsDesc'];
                        String valor = item['accionObsDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _terceraAccionObsArbol = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildRevisionCheckBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[300],
        child: CheckboxListTile(
          title: Text('Revisado'),
          // secondary: Icon(Icons.check_box),
          value: _revisionArbol == null ? false : _revisionArbol,
          onChanged: (bool value) {
            setState(() {
              _revisionArbol = value;
            });
          },
          activeColor: Colors.grey,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.platform,
        ),
      ),
    );
  }

  Widget _buildAlertaCheckBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.red[300],
        child: CheckboxListTile(
          title: Text('Alerta'),
          // secondary: Icon(Icons.check_box),
          value: _alertaArbol == null ? false : _alertaArbol,
          onChanged: (bool value) {
            setState(() {
              _alertaArbol = value;
            });
          },
          activeColor: Colors.grey,
          checkColor: Colors.black,
          controlAffinity: ListTileControlAffinity.platform,
        ),
      ),
    );
  }

  Widget _buildAgentePatogenoDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.agentesPatogenos.nombreTabla,
        campoOrdenador: referencia.agentesPatogenos.agentePatogenoOrigenId,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) => _llenarEnfermedades == true
                          ? 'Campo obligatorio'
                          : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Agente patogeno'),
                      value: _agentePatogeno,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['agentePatogenoDesc'];
                        String valor = item['agentePatogenoDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _agentePatogeno = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildLugarPlagaDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.lugarPlaga.nombreTabla,
        campoOrdenador: referencia.lugarPlaga.lugarPlagaDesc,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) => _llenarEnfermedades == true
                          ? 'Campo obligatorio'
                          : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Lugar plaga'),
                      value: _lugarPlaga,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['lugarPlagaDesc'];
                        String valor = item['lugarPlagaDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _lugarPlaga = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  Widget _buildSintomaDropDown() {
    return FutureBuilder(
      future: campo(
        nombreTabla: referencia.sintomas.nombreTabla,
        campoOrdenador: referencia.sintomas.sintomaDesc,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<String, dynamic>> listado = snapshot.data;
        return snapshot.hasData
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonFormField<String>(
                      validator: (value) => _llenarEnfermedades == true
                          ? 'Campo obligatorio'
                          : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.arrowCircleDown),
                      dropdownColor: Colors.green[50],
                      elevation: 5,
                      isExpanded: true,
                      hint: Text('Sintoma'),
                      value: _sintoma,
                      items: listado.map((Map<String, dynamic> item) {
                        String nombre = item['sintomaDesc'];
                        String valor = item['sintomaDesc'];
                        return DropdownMenuItem(
                          child: Text(nombre),
                          value: valor,
                        );
                      }).toList(),
                      onChanged: (String valorNuevo) {
                        setState(() {
                          _sintoma = valorNuevo;
                        });
                      },
                    ),
                  ),
                ),
              )
            : LoadingWhite();
      },
    );
  }

  List clientes = List();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Column(
              children: [
                Text('El GUI: ${widget.idUnico}'),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                Text('${widget.posicionArbol.toString()}'),
                const SizedBox(height: 8),
                Text('Drop _nombreUsuarioCreacionArbol'),
                const SizedBox(height: 8),
                Text('Drop _nombreUsuarioModificacionArbol'),
                const SizedBox(height: 8),
                Text('Drop Fecha de creacion'),
                const SizedBox(height: 8),
                Text('Fecha modificacion'),
                const SizedBox(height: 8),
                _buildClientesDropDown(),
                const SizedBox(height: 8),
                _buildZonaDropDown(),
                const SizedBox(height: 8),
                _buildCallesDropDown(),
                const SizedBox(height: 8),
                _buildNumeroDireccionTextInput(),
                const SizedBox(height: 8),
                _buildCallesEsquinaDropDown(),
                const SizedBox(height: 8),
                _buildEspecieDropDown(),
                const SizedBox(height: 8),
                _buildDiametroTroncoCmTextInput(),
                const SizedBox(height: 8),
                _buildAlturaArbolMtTextInput(),
                const SizedBox(height: 8),
                _buildAlturaCopaArbolMtTextInput(),
                const SizedBox(height: 8),
                _buildDiametroCopaNsMtTextInput(),
                const SizedBox(height: 8),
                _buildDiametroCopaEoMtTextInput(),
                const SizedBox(height: 8),
                _buildEstadoGeneralDropDown(),
                const SizedBox(height: 8),
                _buildEstadoSanitarioDropDown(),
                const SizedBox(height: 8),
                _buildInclinacionArbolDropDown(),
                const SizedBox(height: 8),
                _buildOrientacionInclinacionDropDown(),
                const SizedBox(height: 8),
                _buildObservacionArbolTextInput(),
                const SizedBox(height: 8),
                _buildPrimeraAccionObsDropDown(),
                const SizedBox(height: 8),
                _buildSegundaAccionObsDropDown(),
                const SizedBox(height: 8),
                _buildTerceraAccionObsDropDown(),
                const SizedBox(height: 8),
                _buildRevisionCheckBox(),
                const SizedBox(height: 8),
                _buildAlertaCheckBox(),
                const SizedBox(height: 8),
                FlatButton(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  onPressed: () async {
                    await tomarImagenArbol(picker);
                    setState(() {
                      _countFotosArbol = _fotosArbolPath.length;
                      _fotosArbolFile = [];
                      _fotosArbolPath.forEach((fotoPath) {
                        _fotosArbolFile.add(File(fotoPath));
                        print('se imprime el path de la foto $fotoPath');
                      });
                    });
                  },
                  color: Colors.green[400],
                  child: Text('Sacar Foto Arbol ($_countFotosArbol)'),
                ),

                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        if (_fotosArbolFile == null) ...[
                          Text('No hay imagenes')
                        ] else if (_fotosArbolFile.length == 1) ...[
                          Image.file(_fotosArbolFile[0])
                        ] else if (_fotosArbolFile.length == 2) ...[
                          Image.file(_fotosArbolFile[0]),
                          const SizedBox(height: 8),
                          Image.file(_fotosArbolFile[1]),
                        ] else if (_fotosArbolFile.length == 3) ...[
                          Image.file(_fotosArbolFile[0]),
                          const SizedBox(height: 8),
                          Image.file(_fotosArbolFile[1]),
                          const SizedBox(height: 8),
                          Image.file(_fotosArbolFile[2]),
                        ]
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  color: Colors.yellow[600],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('ENFERMEDAD (SI HUBIESE)'),
                        const SizedBox(height: 8),
                        _buildAgentePatogenoDropDown(),
                        const SizedBox(height: 8),
                        _buildLugarPlagaDropDown(),
                        const SizedBox(height: 8),
                        _buildSintomaDropDown(),
                        const SizedBox(height: 8),
                        FlatButton(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          onPressed: () async {
                            await tomarImagenEnfermedad(picker);
                            setState(() {
                              _countFotosEnfermedad =
                                  _fotosEnfermedadPath.length;
                              _fotosEnfermedadFile = [];
                              _fotosEnfermedadPath.forEach((fotoPath) {
                                _fotosEnfermedadFile.add(File(fotoPath));
                              });
                            });
                          },
                          color: Colors.orange[400],
                          child: Text(
                              'Sacar Foto Enfermedad ($_countFotosEnfermedad)'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black45, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                if (_fotosEnfermedadFile == null) ...[
                                  Text('No hay imagenes')
                                ] else if (_fotosEnfermedadFile.length ==
                                    1) ...[
                                  Image.file(_fotosEnfermedadFile[0])
                                ] else if (_fotosEnfermedadFile.length ==
                                    2) ...[
                                  Image.file(_fotosEnfermedadFile[0]),
                                  const SizedBox(height: 8),
                                  Image.file(_fotosEnfermedadFile[1]),
                                ] else if (_fotosEnfermedadFile.length ==
                                    3) ...[
                                  Image.file(_fotosEnfermedadFile[0]),
                                  const SizedBox(height: 8),
                                  Image.file(_fotosEnfermedadFile[1]),
                                  const SizedBox(height: 8),
                                  Image.file(_fotosEnfermedadFile[2]),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    List<dynamic> _idNfcHistoriaUltimo = [];
                    _idNfcHistoriaUltimo.add(widget.idUnico);
                    if (_lugarPlaga != null &&
                        _agentePatogeno != null &&
                        _sintoma != null) {
                      _llenarEnfermedades = false;
                    }

                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        Enfermedad enfermedad = Enfermedad(
                          sintoma: _sintoma,
                          agentePatogeno: _agentePatogeno,
                          lugarPlaga: _lugarPlaga,
                        );
                        _enfermedad = enfermedad;
                        ArbolEntity arbol = ArbolEntity(
                          guiArbol: gui.v1(),
                          idArbol: null,
                          idNfcHistoria: _idNfcHistoriaUltimo,
                          clienteArbol: _clienteArbol,
                          zonaArbol: _zonaArbol.split(",")[0],
                          calleArbol: _calleArbol.split(",")[0],
                          nCalleArbol: _nCalleArbol,
                          esquinaCalleArbol:
                              _esquinaCalleArbol ?? "No es esquina",
                          especieArbol: _especieArbol,
                          diametroTroncoArbolCm: _diametroTroncoArbolCm,
                          diametroCopaNsArbolMt: _diametroCopaNsArbolMt,
                          diametroCopaEoArbolMt: _diametroCopaEoArbolMt,
                          alturaArbolArbolMt: _alturaArbolArbolMt,
                          alturaCopaArbolMt: _alturaCopaArbolMt,
                          estadoGeneralArbol: _estadoGeneralArbol,
                          estadoSanitarioArbol: _estadoSanitarioArbol,
                          enfermedad: _enfermedad,
                          inclinacionTroncoArbol: _inclinacionTroncoArbol,
                          orientacionInclinacionArbol:
                              _orientacionInclinacionArbol,
                          obsArbolHistoria: [_obsArbolHistoria],
                          accionObsArbol: _accionObsArbol ?? "Sin acciones",
                          segundaAccionObsArbol:
                              _segundaAccionObsArbol ?? "Sin acciones",
                          terceraAccionObsArbol:
                              _terceraAccionObsArbol ?? "Sin acciones",
                          geoReferenciaCapturaArbol: widget.posicionArbol,
                          nombreUsuarioCreacionArbol: null,
                          usuarioModificaArbol: null,
                          fechaCreacionArbol: DateTime.now(),
                          fechaUltimaModArbol: DateTime.now(),
                          alertaArbol: _alertaArbol.toString(),
                          revisionArbol: _revisionArbol.toString(),
                          fotosArbol: _fotosArbolPath,
                          fotosEnfermedad: _fotosEnfermedadPath,
                        );
                        _arbol = arbol;
                      });
                    }
                  },
                  color: Colors.green,
                  child: Text('Grabar Datos'),
                ),

                // we will work in here
              ],
            )
          ],
        ),
      ),
    );
  }
}
