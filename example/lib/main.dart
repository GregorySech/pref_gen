import 'package:flutter/material.dart';
import 'package:athos/athos.dart';
import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
part 'main.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}



@ReactivePreferencesHolder()
abstract class SharedSettings implements SharedSettingsPreferences {
  int counter;

  factory SharedSettings(PreferenceAdapter adapter) = _$SharedSettings;
}


class MyHomePage extends StatelessWidget {
  final SharedSettings settings = SharedSettings(SharedPreferencesAdapter());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generated settings demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: settings.counterStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  child: Text(
                    '${snapshot.data ?? 0}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => settings.counter = (settings.counter ?? 0) + 1,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
