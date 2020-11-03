import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NfcEntity extends Equatable {
  final String idNfc;
  final String body;
  NfcEntity({@required this.idNfc, this.body}) : super([idNfc]);
}
