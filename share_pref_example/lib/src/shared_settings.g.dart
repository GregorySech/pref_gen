// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_settings.dart';

// **************************************************************************
// ReactiveSharedPreferencesGenerator
// **************************************************************************

class _$SharedSettings implements SharedSettings {
  _$SharedSettings(PreferenceAdapter adapter) : this._adapter = adapter {
    dddSink = (StreamController<String>.broadcast()
          ..stream.listen((value) async {
            await adapter.setString("ddd", value);
            _dddSubject.add(value);
          }))
        .sink;
    kkkSink = (StreamController<int>.broadcast()
          ..stream.listen((value) async {
            await adapter.setInt("kkk", value);
            _kkkSubject.add(value);
          }))
        .sink;
    cccSink = (StreamController<bool>.broadcast()
          ..stream.listen((value) async {
            await adapter.setBool("ccc", value);
            _cccSubject.add(value);
          }))
        .sink;
    eeeSink = (StreamController<double>.broadcast()
          ..stream.listen((value) async {
            await adapter.setDouble("eee", value);
            _eeeSubject.add(value);
          }))
        .sink;
    oooSink = (StreamController<List<String>>.broadcast()
          ..stream.listen((value) async {
            await adapter.setStringList("ooo", value);
            _oooSubject.add(value);
          }))
        .sink;
    _adapter.getString("ddd").then(dddSink.add);
    _adapter.getInt("kkk").then(kkkSink.add);
    _adapter.getBool("ccc").then(cccSink.add);
    _adapter.getDouble("eee").then(eeeSink.add);
    _adapter.getStringList("ooo").then(oooSink.add);
  }

  final PreferenceAdapter _adapter;

  final BehaviorSubject<String> _dddSubject = BehaviorSubject<String>();

  final BehaviorSubject<int> _kkkSubject = BehaviorSubject<int>();

  final BehaviorSubject<bool> _cccSubject = BehaviorSubject<bool>();

  final BehaviorSubject<double> _eeeSubject = BehaviorSubject<double>();

  final BehaviorSubject<List<String>> _oooSubject =
      BehaviorSubject<List<String>>();

  Sink<String> dddSink;

  Sink<int> kkkSink;

  Sink<bool> cccSink;

  Sink<double> eeeSink;

  Sink<List<String>> oooSink;

  Stream<String> get dddStream => _dddSubject.asBroadcastStream();
  Stream<int> get kkkStream => _kkkSubject.asBroadcastStream();
  Stream<bool> get cccStream => _cccSubject.asBroadcastStream();
  Stream<double> get eeeStream => _eeeSubject.asBroadcastStream();
  Stream<List<String>> get oooStream => _oooSubject.asBroadcastStream();
  void dispose() {
    dddSink.close();
    kkkSink.close();
    cccSink.close();
    eeeSink.close();
    oooSink.close();
  }
}
