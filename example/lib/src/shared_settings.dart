import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
part 'shared_settings.g.dart';

@ReactivePreferencesHolder()
abstract class SharedSettings implements SharedSettingsPrefences {
  String name;
  String surname;
  int age;
  bool height;
  List<String> favoriteFoods;


  factory SharedSettings(PreferenceAdapter adapter) = _$SharedSettings;
}
