import 'dart:async';

/// [PreferenceAdapter] is an abstract wrapper over storage implementations,
/// Provided in [PreferencesHolder] annotated class's constructor.
abstract class PreferenceAdapter {
  /// Reads an [boolean] from storage implementation
  Future<bool> getBool(String key);

  /// Reads an [int] from storage implementation
  Future<int> getInt(String key);

  /// Reads an [double] from storage implementation
  Future<double> getDouble(String key);

  /// Reads an [String] from storage implementation
  Future<String> getString(String key);

  /// Reads an [List<String>] from storage implementation
  Future<List<String>> getStringList(String key);

  /// Writes an [boolean] to storage implementation
  Future<void> setBool(String key, bool value);

  /// Writes an [int] to storage implementation
  Future<void> setInt(String key, int value);

  /// Writes an [double] to storage implementation
  Future<void> setDouble(String key, double value);

  /// Writes an [String] to storage implementation
  Future<void> setString(String key, String value);

  /// Writes an [List<String>] to storage implementation
  Future<void> setStringList(String key, List<String> value);
}
