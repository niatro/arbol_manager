import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/server_prueba.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';

class FichaArbolPage extends StatelessWidget {
  final ArbolEntity arbol;
  const FichaArbolPage({
    Key key,
    @required this.arbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        '$urlProduccion/img_arboles/${arbol.fotosArbol[0].replaceAll("\"", '')}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('detalles'),
      ),
      body: Center(
        child: Column(
          children: [
            // Text(arbol.fotosArbol[0].toString().replaceAll("\"", '')),
            if (arbol.fotosArbol == null) ...[
              Text('No hay imagenes')
            ] else if (arbol.fotosArbol.length == 1) ...[
              InteractiveViewer(
                  child: Image.network(
                '$urlProduccion/img_arboles/${arbol.fotosArbol[0].replaceAll("\"", '')}',
                // loadingBuilder: (context, child, progress) {
                //   return progress == null ? child : CircularProgressIndicator();
                // },
              )),
            ] else if (arbol.fotosArbol.length == 2) ...[
              Image.network(
                '$urlProduccion+"/img_arboles/"+${arbol.fotosArbol[0]}',
              ),
              const SizedBox(height: 8),
              Image.network(
                '$urlProduccion+"/img_arboles/"+{arbol.fotosArbol[1]}',
              ),
            ] else if (arbol.fotosArbol.length == 3) ...[
              Image.network(
                '$urlProduccion+"/img_arboles/"+${arbol.fotosArbol[0]}',
              ),
              const SizedBox(height: 8),
              Image.network(
                '$urlProduccion+"/img_arboles/"+${arbol.fotosArbol[1]}',
              ),
              const SizedBox(height: 8),
              Image.network(
                '$urlProduccion+"/img_arboles/"+${arbol.fotosArbol[2]}',
              ),
            ]
          ],
        ),
      ),
    );
  }
}
