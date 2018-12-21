// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// ReactiveSharedPreferencesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) : this._adapter = adapter {
    counterSink = (StreamController<int>.broadcast()
          ..stream.listen((value) async {
            await adapter.setInt("counter", value);
            _counterSubject.add(value);
          }))
        .sink;
    _adapter.getInt("counter").then(counterSink.add);
  }

  final PreferenceAdapter _adapter;

  final BehaviorSubject<int> _counterSubject = BehaviorSubject<int>();

  Sink<int> counterSink;

  Stream<int> get counterStream => _counterSubject.asBroadcastStream();
  int get counter => _counterSubject.value;
  set counter(int value) => counterSink.add(value);
  void dispose() {
    counterSink.close();
  }
}

abstract class SharedSettingsPreferences {
  Sink<int> counterSink;

  Stream<int> get counterStream;
}
