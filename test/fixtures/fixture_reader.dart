import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
