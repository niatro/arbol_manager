import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/formato.dart';

class InicioSesion extends StatefulWidget {
  final Function cambiarEstado;
  InicioSesion({this.cambiarEstado});
  @override
  _InicioSesionState createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          elevation: 0.0,
          title: Text('Iniciar Sesión en Arbolardo'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.cambiarEstado();
                },
                icon: Icon(Icons.person),
                label: Text('Registrarse'))
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          inputFormDecorador.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'Introduzca un mail valido' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          inputFormDecorador.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Crea una contraseña mas larga'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.brown[400],
                      child: Text(
                        'Iniciar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        /// La funcion de validacion considera que los validator
                        /// estan ok cuando devuelven null
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style:
                          TextStyle(color: Colors.brown[800], fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            )));
  }
}
