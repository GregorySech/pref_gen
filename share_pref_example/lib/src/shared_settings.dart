import 'package:shared_pref_annotation/shared_pref_annotation.dart';
part 'shared_settings.g.dart';

@PreferencesHolder()
abstract class SharedSettings {
  String ddd;
  int kkk;
  bool ccc;
  double eee;
  List<String> ooo;

  factory SharedSettings(PreferenceAdapter adapter) = _$SharedSettings;
}
