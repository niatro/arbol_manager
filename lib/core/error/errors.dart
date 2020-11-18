import 'package:flutterapparbol/features/arbol/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;
  UnexpectedValueError(this.valueFailure);
  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. mierda. ';
    return Error.safeToString('$explanation la falla fue : $valueFailure');
  }
}
