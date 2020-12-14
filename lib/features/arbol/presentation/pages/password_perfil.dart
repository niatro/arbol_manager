import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/core/error/exceptions.dart';
import 'package:flutterapparbol/features/arbol/application/auth/auth_bloc.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/arboles_remote_data_source.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/form_local_source_sql.dart';
import 'package:flutterapparbol/features/arbol/data/datasources/local_data_estructuras.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/domain/usecases/get_datos_form_usecase.dart';
import 'package:flutterapparbol/features/arbol/presentation/routes/router.gr.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class PasswordPerfil extends StatefulWidget {
  @override
  _PasswordPerfilState createState() => _PasswordPerfilState();
}

class _PasswordPerfilState extends State<PasswordPerfil> {
  ArbolesRemoteDataSourceImpl remoteDataSource;
  http.Client client = http.Client();
  final EsquemaDataDeSQL referencia = EsquemaDataDeSQL();

  UserEntity _usuario;
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _mensage = 'Ingresa tu contraseña';

  @override
  Widget build(BuildContext context) {
    ArbolesRemoteDataSourceImpl remoteDataSource = ArbolesRemoteDataSourceImpl(
      client: client,
      referencia: referencia,
    );
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          unauthenticated: (_) =>
              ExtendedNavigator.of(context).replace(Routes.signInPage),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Verificar'),
            leading: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
          ),
          body: Form(
            key: _formKey,
            child: Container(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text('$_mensage'),
                      const SizedBox(height: 30),
                      TextFormField(
                        validator: (String value) {
                          if (value.length < 6) {
                            return 'Tu password es muy cortp';
                          } else if (value.isEmpty) {
                            return 'Debe ingresar un valor';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "La misma que usaste al inicio",
                          labelText: "repite contraseña",
                        ),
                        autocorrect: false,
                        obscureText: true,
                        keyboardType: TextInputType.name,
                        onSaved: (String valorNuevo) {
                          setState(() {
                            _password = valorNuevo;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      FlatButton(
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          if (_formKey.currentState.validate()) {
                            try {
                              UserEntity user = await remoteDataSource
                                  .getUserInfoRemoteData(password: _password);
                              if (user.detallePerfilUser == "Admin" ||
                                  user.detallePerfilUser == "Capturador") {
                                ExtendedNavigator.of(context).push(
                                    Routes.homeCatastrador,
                                    arguments: HomeCatastradorArguments(
                                        usuario: user));
                              } else if (user.detallePerfilUser ==
                                  "Visualizador") {
                                ExtendedNavigator.of(context).push(
                                    Routes.homeCliente,
                                    arguments:
                                        HomeClienteArguments(usuario: user));
                              }
                            } on PassException {
                              setState(() {
                                _mensage = "Contraseña incorrecta";
                              });
                            } on ServerException {
                              setState(() {
                                _mensage = "Problemas con el servidor";
                              });
                            }
                          }
                        },
                        color: Colors.green,
                        child: Text('Ingresar'),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
