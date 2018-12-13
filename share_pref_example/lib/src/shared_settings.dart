import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
part 'shared_settings.g.dart';

@ReactivePreferencesHolder()
abstract class SharedSettings {

  String ddd;
  int kkk;
  bool ccc;
  double eee;
  List<String> ooo;

  factory SharedSettings(PreferenceAdapter adapter) = _$SharedSettings;
}
