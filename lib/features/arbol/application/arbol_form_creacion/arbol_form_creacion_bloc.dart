import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'arbol_form_creacion_event.dart';

part 'arbol_form_creacion_state.dart';

class ArbolFormCreacionBloc
    extends Bloc<ArbolFormCreacionEvent, ArbolFormCreacionState> {
  @override
  ArbolFormCreacionState get initialState => InitialArbolFormCreacionState();

  @override
  Stream<ArbolFormCreacionState> mapEventToState(
      ArbolFormCreacionEvent event) async* {
    // TODO: Add your event logic
  }
}
