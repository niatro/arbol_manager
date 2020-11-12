import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';
import 'package:flutterapparbol/features/arbol/presentation/widgets/project_widgets.dart';
import 'package:flutterapparbol/injection_container.dart';

class ArbolesEntityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<ArbolesEntityBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<ArbolesEntityBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              BlocBuilder<ArbolesEntityBloc, ArbolesEntityState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Registrando',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is LoadedUser) {
                    return MessageDisplay(
                        message: state.usuario.detallePerfilUser);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              LogInSector(),
            ],
          ),
        ),
      ),
    );
  }
}

class LogInSector extends StatefulWidget {
  const LogInSector({
    Key key,
  }) : super(key: key);

  @override
  _LogInSectorState createState() => _LogInSectorState();
}

class _LogInSectorState extends State<LogInSector> {
  final controller = TextEditingController();
  String inputRut;
  String inputPass;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Introduce RUT'),
          onChanged: (value) {
            inputRut = value;
          },
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Introduce Password'),
          onChanged: (value) {
            inputPass = value;
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 60),
            Expanded(
              child: RaisedButton(
                child: Text('Ingresar'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchLoginUserEvent,
              ),
            ),
            SizedBox(width: 60),
          ],
        )
      ],
    );
  }

  void dispatchLoginUserEvent() {
    controller.clear();
    BlocProvider.of<ArbolesEntityBloc>(context)
        .dispatch(LoginUserEvent(inputPass, inputRut));
  }
}
