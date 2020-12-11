import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/application/arbol_mapa/arbol_mapa_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/user_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/catastrador_mapa.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/catastrador_mapa_integrado.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/cliente_mapa_integrado.dart';

import '../../../../injection_auto.dart';

class HomeCliente extends StatelessWidget {
  final UserEntity usuario;
  const HomeCliente({@required this.usuario});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<ArbolMapaBloc>(),
          ),
        ],
        child: ClienteMapaIntegrado(
          usuario: usuario,
        ));
  }
}
