import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
part 'shared_settings.g.dart';

@PreferencesHolder()
abstract class SharedSettings implements SharedSettingsPreferences {
  @DefaultValue("asdasd")
  String name;
  @DefaultValue(0)
  int age;


  factory SharedSettings(PreferenceAdapter adapter) = _$SharedSettings;
}
