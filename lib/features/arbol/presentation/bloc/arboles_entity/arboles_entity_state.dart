part of 'arboles_entity_bloc.dart';

@immutable
abstract class ArbolesEntityState extends Equatable {
  ArbolesEntityState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends ArbolesEntityState {}

class Loading extends ArbolesEntityState {}

class Loaded extends ArbolesEntityState {
  final ArbolesEntity arboles;
  Loaded({@required this.arboles}) : super([arboles]);
}

class Error extends ArbolesEntityState {
  final String message;
  Error({@required this.message}) : super([message]);
}
