part of 'arboles_entity_bloc.dart';

@immutable
abstract class ArbolesEntityState extends Equatable {
  ArbolesEntityState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends ArbolesEntityState {}

class Loading extends ArbolesEntityState {}

class Updating extends ArbolesEntityState {}

class Saving extends ArbolesEntityState {}

class Saved extends ArbolesEntityState {
  final ServerGrabarSuccess success;
  Saved({@required this.success}) : super([success]);
}

class Updated extends ArbolesEntityState {
  final ServerUpdateSuccess success;
  Updated({@required this.success}) : super([success]);
}

class Loaded extends ArbolesEntityState {
  final ArbolesEntity arboles;
  Loaded({@required this.arboles}) : super([arboles]);
}

class Error extends ArbolesEntityState {
  final String message;
  Error({@required this.message}) : super([message]);
}
