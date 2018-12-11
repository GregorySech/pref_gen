// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_settings.dart';

// **************************************************************************
// SharedPreferenecesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) {
    this._adapter = adapter;
  }

  PreferenceAdapter _adapter;

  String get ddd {
    return "ddd";
  }

  set ddd(String value) {
    _adapter.setString("ddd", value);
  }

  int get kkk {
    return 0;
  }

  set kkk(int value) {
    _adapter.setInt("kkk", value);
  }

  bool get ccc {
    return false;
  }

  Future<void> fetchCache() {
  }

  Future<bool> cccAsync() {
    return _adapter.getBool("ccc");
  }

  set ccc(bool value) {
    _adapter.setBool("ccc", value);
  }

  double get eee {
    return 0;
  }

  set eee(double value) {
    _adapter.setDouble("eee", value);
  }

  List<String> get ooo {
    return [];
  }

  set ooo(List<String> value) {
    _adapter.setStringList("ooo", value);
  }
}