import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutterapparbol/features/arbol/presentation/bloc/arboles_entity/arboles_entity_bloc.dart';

class ArbolesControles extends StatefulWidget {
  const ArbolesControles({
    Key key,
  }) : super(key: key);

  @override
  _ArbolesControlesState createState() => _ArbolesControlesState();
}

class _ArbolesControlesState extends State<ArbolesControles> {
  final controller = TextEditingController();
  String inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'introducir coordenada'),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            getArbolesCercanos();
          },
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: getArbolesCercanos,
                child: Text('Buscar Cerca'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: RaisedButton(
                onPressed: getArbolesPorNFC,
                child: Text('Buscar por Chip'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void getArbolesCercanos() {
    controller.clear();
    bloc.BlocProvider.of<ArbolesEntityBloc>(context)
        .add(GetArbolesEntityCercanosEvent(inputStr));
  }

//TODO: este metodo debería dispararce despues del metodo getIdNFC
  void getArbolesPorNFC() {
    controller.clear();
    bloc.BlocProvider.of<ArbolesEntityBloc>(context)
        .add(GetArbolesEntityPorIdNFCEvent('safoewfw'));
  }
}
