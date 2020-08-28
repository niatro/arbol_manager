import 'package:equatable/equatable.dart';
import 'package:flutterapparbol/features/arbol/domain/entities/form_entity.dart';
import 'package:meta/meta.dart';

class FormEntityModelo extends FormEntity {
  final List<Cliente> clienteArbol;
  final List<Zona> zonaArbol;
  final List<Calle> calleArbol;
  final List<CalleEsquina> esquinaCalleArbol;
  final List<Especie> especieArbol;
  final List<EstadoGeneral> estadoGeneralArbol;
  final List<EstadoSanitario> estadoSanitarioArbol;
  final List<InclinacionTronco> inclinacionTroncoArbol;
  final List<OrientacionInclinacion> orientacionInclinacionArbol;
  final List<AccionObs> accionObsArbol;

  FormEntityModelo({
    @required this.clienteArbol,
    @required this.zonaArbol,
    @required this.calleArbol,
    @required this.esquinaCalleArbol,
    @required this.especieArbol,
    @required this.estadoGeneralArbol,
    @required this.estadoSanitarioArbol,
    @required this.inclinacionTroncoArbol,
    @required this.orientacionInclinacionArbol,
    @required this.accionObsArbol,
  });

  factory FormEntityModelo.fromJson(Map<String, dynamic> json) {
    return FormEntityModelo(
      clienteArbol: json["clienteArbol"],
      zonaArbol: json["zonaArbol"],
      calleArbol: json["calleArbol"],
      esquinaCalleArbol: json["esquinaCalleArbol"],
      especieArbol: json["especieArbol"],
      estadoGeneralArbol: json["estadoGeneralArbol"],
      estadoSanitarioArbol: json["estadoSanitarioArbol"],
      inclinacionTroncoArbol: json["inclinacionTroncoArbol"],
      orientacionInclinacionArbol: json["orientacionInclinacionArbol"],
      accionObsArbol: json["accionObsArbol"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['clienteArbol'] = this.clienteArbol;
    data['zonaArbol'] = this.zonaArbol;
    data['calleArbol'] = this.calleArbol;
    data['esquinaCalleArbol'] = this.esquinaCalleArbol;
    data['especieArbol'] = this.especieArbol;
    data['estadoGeneralArbol'] = this.estadoGeneralArbol;
    data['estadoSanitarioArbol'] = this.estadoSanitarioArbol;
    data['inclinacionTroncoArbol'] = this.inclinacionTroncoArbol;
    data['orientacionInclinacionArbol'] = this.orientacionInclinacionArbol;
    data['accionObsArbol'] = this.accionObsArbol;
    return data;
  }

  FormEntity toEntity() {
    return FormEntity(
      clienteArbol: this.clienteArbol,
      zonaArbol: this.zonaArbol,
      calleArbol: this.calleArbol,
      esquinaCalleArbol: this.esquinaCalleArbol,
      especieArbol: this.especieArbol,
      estadoGeneralArbol: this.estadoGeneralArbol,
      estadoSanitarioArbol: this.estadoSanitarioArbol,
      inclinacionTroncoArbol: this.inclinacionTroncoArbol,
      orientacionInclinacionArbol: this.orientacionInclinacionArbol,
      accionObsArbol: this.accionObsArbol,
    );
  }
}
