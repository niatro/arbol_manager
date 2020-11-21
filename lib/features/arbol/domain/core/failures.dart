import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({
    @required String failedValue,
    @required int max,
  }) = ExceedingLength<T>;
  const factory ValueFailure.empty({
    @required T failedValue,
  }) = Empty<T>;
  const factory ValueFailure.multiline({
    @required T failedValue,
  }) = Multiline<T>;
  const factory ValueFailure.listTooLong({
    @required KtList failedValue,
    @required int max,
  }) = ListTooLong<T>;
  const factory ValueFailure.invalidEmail({
    @required T failedValue,
  }) = InvalidEmail<T>;
  const factory ValueFailure.shortPassword({
    @required T failedValue,
  }) = ShortPassword<T>;
  const factory ValueFailure.invalidRut({
    @required T failedValue,
  }) = InvalidRut<T>;
}
