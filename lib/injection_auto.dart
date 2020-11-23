import 'package:flutterapparbol/injection_auto.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

// Se transformo a futuro porque tiene la clase
// Shared preferences que necesita inicializarce
@injectableInit
Future<void> configureInjection(String env) async {
  await $initGetIt(getIt, environment: env);
}
