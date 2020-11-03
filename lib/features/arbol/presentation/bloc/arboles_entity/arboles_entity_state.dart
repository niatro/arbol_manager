part of 'arboles_entity_bloc.dart';

@immutable
abstract class ArbolesEntityState extends Equatable {
  ArbolesEntityState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends ArbolesEntityState {}

class Loading extends ArbolesEntityState {}

class UpdatingArbol extends ArbolesEntityState {}

class UpdatingForm extends ArbolesEntityState {}

class GettingForm extends ArbolesEntityState {}

class GettingUser extends ArbolesEntityState {}

class GettingNfc extends ArbolesEntityState {}

class GettingCoord extends ArbolesEntityState {}

class ComprobandoIdNfc extends ArbolesEntityState {}

class Saving extends ArbolesEntityState {}

class Saved extends ArbolesEntityState {
  final ServerGrabarSuccess success;
  Saved({@required this.success}) : super([success]);
}

class UpdatedArbol extends ArbolesEntityState {
  final ServerUpdateSuccess success;
  UpdatedArbol({@required this.success}) : super([success]);
}

class UpdatedSql extends ArbolesEntityState {
  final ServerActualizarFormSuccess success;
  UpdatedSql({@required this.success}) : super([success]);
}

class UpdatedForm extends ArbolesEntityState {
  final FormEntity formData;
  UpdatedForm({@required this.formData}) : super([formData]);
}

class LoadedArboles extends ArbolesEntityState {
  final ArbolesEntity arboles;
  LoadedArboles({@required this.arboles}) : super([arboles]);
}

class LoadedUser extends ArbolesEntityState {
  final UserEntity usuario;
  LoadedUser({@required this.usuario}) : super([usuario]);
}

class ReadedNfc extends ArbolesEntityState {
  final NfcEntity nfcEntity;
  ReadedNfc({@required this.nfcEntity}) : super([nfcEntity]);
}

class GettedCoord extends ArbolesEntityState {
  final LatLng latLng;
  GettedCoord({@required this.latLng}) : super([latLng]);
}

class CheckedIdNfc extends ArbolesEntityState {
  final bool existe;
  CheckedIdNfc({@required this.existe}) : super([existe]);
}

class Error extends ArbolesEntityState {
  final String message;
  Error({@required this.message}) : super([message]);
}
