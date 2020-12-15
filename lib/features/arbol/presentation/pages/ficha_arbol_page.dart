import 'package:flutter/material.dart';
import 'package:flutterapparbol/core/constants/server_prueba.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/arboles_entity.dart';

class FichaArbolPage extends StatelessWidget {
  final ArbolEntity arbol;
  const FichaArbolPage({
    Key key,
    @required this.arbol,
  }) : super(key: key);

  Widget Tarjeta(String text) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    print(
        '$urlProduccion/img_arboles/${arbol.fotosArbol[0].replaceAll("\"", '')}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('detalles'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (arbol.fotosArbol == null) ...[
                  Text('No hay imagenes')
                ] else if (arbol.fotosArbol.length == 1) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InteractiveViewer(
                          child: Image.network(
                        '$urlProduccion/img_arboles/${arbol.fotosArbol[0].replaceAll("\"", '')}',
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : CircularProgressIndicator();
                        },
                      )),
                    ),
                  ),
                ] else if (arbol.fotosArbol.length == 2) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InteractiveViewer(
                        child: Image.network(
                          '$urlProduccion/img_arboles/${arbol.fotosArbol[0].replaceAll("\"", '')}',
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InteractiveViewer(
                        child: Image.network(
                          '$urlProduccion/img_arboles/${arbol.fotosArbol[1].replaceAll("\"", '')}',
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ),
                ] else if (arbol.fotosArbol.length == 3) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InteractiveViewer(
                        child: Image.network(
                          '$urlProduccion/img_arboles/${arbol.fotosArbol[0].replaceAll("\"", '')}',
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InteractiveViewer(
                        child: Image.network(
                          '$urlProduccion/img_arboles/${arbol.fotosArbol[1].replaceAll("\"", '')}',
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InteractiveViewer(
                        child: Image.network(
                          '$urlProduccion/img_arboles/${arbol.fotosArbol[2].replaceAll("\"", '')}',
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
                Tarjeta(
                    'ESPECIE:   ${arbol.especieArbol} / Numero ID = ${arbol.idArbol.toString()} / Estado General = ${arbol.estadoGeneralArbol} '),
                Tarjeta(
                    'DIRECCION:   ${arbol.calleArbol}  ${arbol.nCalleArbol.toString()} / Esquina = ${arbol.esquinaCalleArbol.toString()} / ${arbol.zonaArbol}'),
                Tarjeta(
                    'DASOMETRIA:   Altura (m) = ${arbol.alturaArbolArbolMt.toString()} / DAP (cm) = ${arbol.diametroTroncoArbolCm.toString()} / Altura Inicio Copa (m) = ${arbol.alturaCopaArbolMt.toString()} / Diametro Copa NS (m) = ${arbol.diametroCopaNsArbolMt.toString()} / Diametro Copa EO (m) = ${arbol.diametroCopaEoArbolMt.toString()}'),
                Tarjeta(
                    'HISTORIAL OBSERVACIONES: ${arbol.obsArbolHistoria.map((e) => e)}  FECHA CREACION: ${arbol.fechaCreacionArbol.toString()}  /  FECHA ULTIMA MOD: ${arbol.fechaUltimaModArbol.toString()}'),
                Tarjeta(
                    'ESTADO SANITARIO:   General = ${arbol.estadoSanitarioArbol} / ENFERMEDAD: Agente Patogeno = ${arbol.enfermedad.agentePatogeno} / Sintoma = ${arbol.enfermedad.sintoma} / Localizacion = ${arbol.enfermedad.lugarPlaga}'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InteractiveViewer(
                      child: Image.network(
                        '$urlProduccion/img_arboles/${arbol.fotosEnfermedad[0].replaceAll("\"", '')}',
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
