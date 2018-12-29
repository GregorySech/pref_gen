// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_settings.dart';

// **************************************************************************
// ReactiveSharedPreferencesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) : this._adapter = adapter {
    nameSink = (StreamController<String>.broadcast()
          ..stream.listen((value) async {
            await adapter.setString("name", value);
            _nameSubject.add(value);
          }))
        .sink;
    ageSink = (StreamController<int>.broadcast()
          ..stream.listen((value) async {
            await adapter.setInt("age", value);
            _ageSubject.add(value);
          }))
        .sink;
    tagsSink = (StreamController<List<String>>.broadcast()
          ..stream.listen((value) async {
            await adapter.setStringList("tags", value);
            _tagsSubject.add(value);
          }))
        .sink;
    _adapter.getString("name").then((value) {
      return value ?? 'asdasd';
    }).then(nameSink.add);
    _adapter.getInt("age").then((value) {
      return value ?? 0;
    }).then(ageSink.add);
    _adapter.getStringList("tags").then((value) {
      return value ?? ['AAA', 'BBB'];
    }).then(tagsSink.add);
  }

  final PreferenceAdapter _adapter;

  final BehaviorSubject<String> _nameSubject = BehaviorSubject<String>();

  final BehaviorSubject<int> _ageSubject = BehaviorSubject<int>();

  final BehaviorSubject<List<String>> _tagsSubject =
      BehaviorSubject<List<String>>();

  Sink<String> nameSink;

  Sink<int> ageSink;

  Sink<List<String>> tagsSink;

  Stream<String> get nameStream => _nameSubject.asBroadcastStream();
  Stream<int> get ageStream => _ageSubject.asBroadcastStream();
  Stream<List<String>> get tagsStream => _tagsSubject.asBroadcastStream();
  String get name => _nameSubject.value;
  int get age => _ageSubject.value;
  List<String> get tags => _tagsSubject.value;
  set name(String value) => nameSink.add(value);
  set age(int value) => ageSink.add(value);
  set tags(List<String> value) => tagsSink.add(value);
  void dispose() {
    nameSink.close();
    ageSink.close();
    tagsSink.close();
  }
}

abstract class SharedSettingsPreferences {
  Sink<String> nameSink;

  Sink<int> ageSink;

  Sink<List<String>> tagsSink;

  Stream<String> get nameStream;
  Stream<int> get ageStream;
  Stream<List<String>> get tagsStream;
}
