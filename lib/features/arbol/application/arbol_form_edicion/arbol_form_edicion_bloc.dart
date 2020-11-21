import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'arbol_form_edicion_event.dart';

part 'arbol_form_edicion_state.dart';

class ArbolFormEdicionBloc
    extends Bloc<ArbolFormEdicionEvent, ArbolFormEdicionState> {
  @override
  ArbolFormEdicionState get initialState => InitialArbolFormEdicionState();

  @override
  Stream<ArbolFormEdicionState> mapEventToState(
      ArbolFormEdicionEvent event) async* {
    // TODO: Add your event logic
  }
}
