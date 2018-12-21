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
    surnameSink = (StreamController<String>.broadcast()
          ..stream.listen((value) async {
            await adapter.setString("surname", value);
            _surnameSubject.add(value);
          }))
        .sink;
    ageSink = (StreamController<int>.broadcast()
          ..stream.listen((value) async {
            await adapter.setInt("age", value);
            _ageSubject.add(value);
          }))
        .sink;
    heightSink = (StreamController<bool>.broadcast()
          ..stream.listen((value) async {
            await adapter.setBool("height", value);
            _heightSubject.add(value);
          }))
        .sink;
    favoriteFoodsSink = (StreamController<List<String>>.broadcast()
          ..stream.listen((value) async {
            await adapter.setStringList("favoriteFoods", value);
            _favoriteFoodsSubject.add(value);
          }))
        .sink;
    _adapter.getString("name").then(nameSink.add);
    _adapter.getString("surname").then(surnameSink.add);
    _adapter.getInt("age").then(ageSink.add);
    _adapter.getBool("height").then(heightSink.add);
    _adapter.getStringList("favoriteFoods").then(favoriteFoodsSink.add);
  }

  final PreferenceAdapter _adapter;

  final BehaviorSubject<String> _nameSubject = BehaviorSubject<String>();

  final BehaviorSubject<String> _surnameSubject = BehaviorSubject<String>();

  final BehaviorSubject<int> _ageSubject = BehaviorSubject<int>();

  final BehaviorSubject<bool> _heightSubject = BehaviorSubject<bool>();

  final BehaviorSubject<List<String>> _favoriteFoodsSubject =
      BehaviorSubject<List<String>>();

  Sink<String> nameSink;

  Sink<String> surnameSink;

  Sink<int> ageSink;

  Sink<bool> heightSink;

  Sink<List<String>> favoriteFoodsSink;

  Stream<String> get nameStream => _nameSubject.asBroadcastStream();
  Stream<String> get surnameStream => _surnameSubject.asBroadcastStream();
  Stream<int> get ageStream => _ageSubject.asBroadcastStream();
  Stream<bool> get heightStream => _heightSubject.asBroadcastStream();
  Stream<List<String>> get favoriteFoodsStream =>
      _favoriteFoodsSubject.asBroadcastStream();
  String get name => _nameSubject.value;
  String get surname => _surnameSubject.value;
  int get age => _ageSubject.value;
  bool get height => _heightSubject.value;
  List<String> get favoriteFoods => _favoriteFoodsSubject.value;
  set name(String value) => nameSink.add(value);
  set surname(String value) => surnameSink.add(value);
  set age(int value) => ageSink.add(value);
  set height(bool value) => heightSink.add(value);
  set favoriteFoods(List<String> value) => favoriteFoodsSink.add(value);
  void dispose() {
    nameSink.close();
    surnameSink.close();
    ageSink.close();
    heightSink.close();
    favoriteFoodsSink.close();
  }
}
