// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_settings.dart';

// **************************************************************************
// SharedPreferenecesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) : this._adapter = adapter;

  final Map<String, dynamic> _cache = Map<String, dynamic>();

  final PreferenceAdapter _adapter;

  Future<String> dddAsync() {
    return _adapter.getString("ddd");
  }

  Future<int> kkkAsync() {
    return _adapter.getInt("kkk");
  }

  Future<bool> cccAsync() {
    return _adapter.getBool("ccc");
  }

  Future<double> eeeAsync() {
    return _adapter.getDouble("eee");
  }

  Future<List<String>> oooAsync() {
    return _adapter.getStringList("ooo");
  }

  Future<void> dddAsyncSet(String value) {
    _cache["ddd"] = value;
    return _adapter.setString("ddd", value);
  }

  Future<void> kkkAsyncSet(int value) {
    _cache["kkk"] = value;
    return _adapter.setInt("kkk", value);
  }

  Future<void> cccAsyncSet(bool value) {
    _cache["ccc"] = value;
    return _adapter.setBool("ccc", value);
  }

  Future<void> eeeAsyncSet(double value) {
    _cache["eee"] = value;
    return _adapter.setDouble("eee", value);
  }

  Future<void> oooAsyncSet(List<String> value) {
    _cache["ooo"] = value;
    return _adapter.setStringList("ooo", value);
  }

  set ddd(String value) {
    _adapter.setString("ddd", value);
    _cache["ddd"] = value;
  }

  set kkk(int value) {
    _adapter.setInt("kkk", value);
    _cache["kkk"] = value;
  }

  set ccc(bool value) {
    _adapter.setBool("ccc", value);
    _cache["ccc"] = value;
  }

  set eee(double value) {
    _adapter.setDouble("eee", value);
    _cache["eee"] = value;
  }

  set ooo(List<String> value) {
    _adapter.setStringList("ooo", value);
    _cache["ooo"] = value;
  }

  String get ddd {
    return _cache["ddd"] as String;
  }

  int get kkk {
    return _cache["kkk"] as int;
  }

  bool get ccc {
    return _cache["ccc"] as bool;
  }

  double get eee {
    return _cache["eee"] as double;
  }

  List<String> get ooo {
    return List<String>.from(_cache["ooo"] as List);
  }
}
