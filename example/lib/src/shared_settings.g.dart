// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_settings.dart';

// **************************************************************************
// SharedPreferenecesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) : this._adapter = adapter {
    this._cache["name"] = 'asdasd';
    this._cache["age"] = 'null';
  }

  final Map<String, dynamic> _cache = Map<String, dynamic>();

  final PreferenceAdapter _adapter;

  Future<String> nameAsync() {
    return _adapter.getString("name");
  }

  Future<int> ageAsync() {
    return _adapter.getInt("age");
  }

  Future<void> nameAsyncSet(String value) {
    _cache["name"] = value;
    return _adapter.setString("name", value);
  }

  Future<void> ageAsyncSet(int value) {
    _cache["age"] = value;
    return _adapter.setInt("age", value);
  }

  set name(String value) {
    _adapter.setString("name", value);
    _cache["name"] = value;
  }

  set age(int value) {
    _adapter.setInt("age", value);
    _cache["age"] = value;
  }

  String get name {
    return _cache["name"] as String;
  }

  int get age {
    return _cache["age"] as int;
  }
}

abstract class SharedSettingsPreferences {
  Future<String> nameAsync();
  Future<int> ageAsync();
  Future<void> nameAsyncSet(String value);
  Future<void> ageAsyncSet(int value);
}
