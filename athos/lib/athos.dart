import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter extends PreferenceAdapter {
  SharedPreferences _sharedPrefs;
  
  Future<SharedPreferences> getSharedPrefs() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
      return _sharedPrefs;
    }
    return _sharedPrefs;
  }

  @override
  Future<bool> getBool(key) => getSharedPrefs().then((settings) => settings.getBool(key));

  @override
  Future<String> getString(key) => getSharedPrefs().then((settings) => settings.getString(key));

  @override
  Future<List<String>> getStringList(key) => getSharedPrefs().then((settings) => settings.getStringList(key));

  @override
  Future<int> getInt(key) => getSharedPrefs().then((settings) => settings.getInt(key));

  @override
  Future<double> getDouble(key) => getSharedPrefs().then((settings) => settings.getDouble(key));

  @override
  Future<void> setBool(key, value) => getSharedPrefs().then((settings) => settings.setBool(key, value));

  @override
  Future<void> setString(key, value) => getSharedPrefs().then((settings) => settings.setString(key, value));

  @override
  Future<void> setStringList(key, value) => getSharedPrefs().then((settings) => settings.setStringList(key, value));

  @override
  Future<void> setInt(key, value) => getSharedPrefs().then((settings) => settings.setInt(key, value));

  @override
  Future<void> setDouble(key, value) => getSharedPrefs().then((settings) => settings.setDouble(key, value));
}