// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_settings.dart';

// **************************************************************************
// SharedPreferenecesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) {
    this._adapter = adapter;
  }

  Map<String, dynamic> _cache = Map<String, dynamic>();

  PreferenceAdapter _adapter;

  Future<String> dddAsync() {
    return _adapter.getString("ddd");
  }

  Future<void> dddAsyncSet(String value) {
    _cache["ddd"] = value;
    return _adapter.setString("ddd", value);
  }

  set ddd(String value) {
    _adapter.setString("ddd", value);
    _cache["ddd"] = value;
  }

  String get ddd {
    return _cache["ddd"] as String;
  }

  Future<int> kkkAsync() {
    return _adapter.getInt("kkk");
  }

  Future<void> kkkAsyncSet(int value) {
    _cache["kkk"] = value;
    return _adapter.setInt("kkk", value);
  }

  set kkk(int value) {
    _adapter.setInt("kkk", value);
    _cache["kkk"] = value;
  }

  int get kkk {
    return _cache["kkk"] as int;
  }

  Future<bool> cccAsync() {
    return _adapter.getBool("ccc");
  }

  Future<void> cccAsyncSet(bool value) {
    _cache["ccc"] = value;
    return _adapter.setBool("ccc", value);
  }

  set ccc(bool value) {
    _adapter.setBool("ccc", value);
    _cache["ccc"] = value;
  }

  bool get ccc {
    return _cache["ccc"] as bool;
  }

  Future<double> eeeAsync() {
    return _adapter.getDouble("eee");
  }

  Future<void> eeeAsyncSet(double value) {
    _cache["eee"] = value;
    return _adapter.setDouble("eee", value);
  }

  set eee(double value) {
    _adapter.setDouble("eee", value);
    _cache["eee"] = value;
  }

  double get eee {
    return _cache["eee"] as double;
  }

  Future<List<String>> oooAsync() {
    return _adapter.getStringList("ooo");
  }

  Future<void> oooAsyncSet(List<String> value) {
    _cache["ooo"] = value;
    return _adapter.setStringList("ooo", value);
  }

  set ooo(List<String> value) {
    _adapter.setStringList("ooo", value);
    _cache["ooo"] = value;
  }

  List<String> get ooo {
    return List<String>.from(_cache["ooo"] as List);
  }
}