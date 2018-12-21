// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_settings.dart';

// **************************************************************************
// SharedPreferenecesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) : this._adapter = adapter;

  final Map<String, dynamic> _cache = Map<String, dynamic>();

  final PreferenceAdapter _adapter;

  Future<String> nameAsync() {
    return _adapter.getString("name");
  }

  Future<String> surnameAsync() {
    return _adapter.getString("surname");
  }

  Future<int> ageAsync() {
    return _adapter.getInt("age");
  }

  Future<bool> heightAsync() {
    return _adapter.getBool("height");
  }

  Future<List<String>> favoriteFoodsAsync() {
    return _adapter.getStringList("favoriteFoods");
  }

  Future<void> nameAsyncSet(String value) {
    _cache["name"] = value;
    return _adapter.setString("name", value);
  }

  Future<void> surnameAsyncSet(String value) {
    _cache["surname"] = value;
    return _adapter.setString("surname", value);
  }

  Future<void> ageAsyncSet(int value) {
    _cache["age"] = value;
    return _adapter.setInt("age", value);
  }

  Future<void> heightAsyncSet(bool value) {
    _cache["height"] = value;
    return _adapter.setBool("height", value);
  }

  Future<void> favoriteFoodsAsyncSet(List<String> value) {
    _cache["favoriteFoods"] = value;
    return _adapter.setStringList("favoriteFoods", value);
  }

  set name(String value) {
    _adapter.setString("name", value);
    _cache["name"] = value;
  }

  set surname(String value) {
    _adapter.setString("surname", value);
    _cache["surname"] = value;
  }

  set age(int value) {
    _adapter.setInt("age", value);
    _cache["age"] = value;
  }

  set height(bool value) {
    _adapter.setBool("height", value);
    _cache["height"] = value;
  }

  set favoriteFoods(List<String> value) {
    _adapter.setStringList("favoriteFoods", value);
    _cache["favoriteFoods"] = value;
  }

  String get name {
    return _cache["name"] as String;
  }

  String get surname {
    return _cache["surname"] as String;
  }

  int get age {
    return _cache["age"] as int;
  }

  bool get height {
    return _cache["height"] as bool;
  }

  List<String> get favoriteFoods {
    return List<String>.from(_cache["favoriteFoods"] as List);
  }
}

abstract class SharedSettingsPrefences {
  Future<String> nameAsync();
  Future<String> surnameAsync();
  Future<int> ageAsync();
  Future<bool> heightAsync();
  Future<List<String>> favoriteFoodsAsync();
  Future<void> nameAsyncSet(String value);
  Future<void> surnameAsyncSet(String value);
  Future<void> ageAsyncSet(int value);
  Future<void> heightAsyncSet(bool value);
  Future<void> favoriteFoodsAsyncSet(List<String> value);
}
