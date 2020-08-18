import 'package:flutter/material.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';

class ArbolesDisplay extends StatelessWidget {
  final ArbolesEntity arbolesEntity;
  const ArbolesDisplay({
    Key key,
    @required this.arbolesEntity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: ListView.builder(
          itemCount: arbolesEntity.listaArbolEntity.length,
          itemBuilder: (_, index) => Text(
            this.arbolesEntity.listaArbolEntity[index].idArbol.toString(),
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
