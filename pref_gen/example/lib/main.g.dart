// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// ReactiveSharedPreferencesGenerator
// **************************************************************************

class _$SharedSettings extends SharedSettingsPreferences
    implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) : this._adapter = adapter {
    counterSink = (StreamController<int>.broadcast()
          ..stream.listen((value) async {
            await adapter.setInt("counter", value);
            _counterSubject.add(value);
          }))
        .sink;
    appbarColorSink = (StreamController<int>.broadcast()
          ..stream.listen((value) async {
            await adapter.setInt("appbarColor", value);
            _appbarColorSubject.add(value);
          }))
        .sink;
    _adapter.getInt("counter").then(counterSink.add);
    _adapter.getInt("appbarColor").then(appbarColorSink.add);
  }

  final PreferenceAdapter _adapter;

  final BehaviorSubject<int> _counterSubject =
      BehaviorSubject<int>(seedValue: null);

  final BehaviorSubject<int> _appbarColorSubject =
      BehaviorSubject<int>(seedValue: null);

  Sink<int> counterSink;

  Sink<int> appbarColorSink;

  Stream<int> get counterStream => _counterSubject.asBroadcastStream();
  Stream<int> get appbarColorStream => _appbarColorSubject.asBroadcastStream();
  int get counter => _counterSubject.value;
  int get appbarColor => _appbarColorSubject.value;
  set counter(int value) => counterSink.add(value);
  set appbarColor(int value) => appbarColorSink.add(value);
}

abstract class SharedSettingsPreferences {
  Sink<int> counterSink;

  Sink<int> appbarColorSink;

  Stream<int> get counterStream;
  Stream<int> get appbarColorStream;
  void dispose() {
    counterSink.close();
    appbarColorSink.close();
  }
}
