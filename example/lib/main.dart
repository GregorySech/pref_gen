import 'package:flutter/material.dart';
import 'package:pref_gen_flutter/pref_gen_flutter.dart';
import 'package:pref_gen_annotations/pref_gen_annotations.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
part 'main.g.dart';

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferences Generator Demo',
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
  int appbarColor;

  factory SharedSettings(PreferenceAdapter adapter) = _$SharedSettings;
}

class MyHomePage extends StatelessWidget {
  final SharedSettings settings = SharedSettings(SharedPreferencesAdapter());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: settings.appbarColorStream,
      builder: (BuildContext context, AsyncSnapshot appbarColorSnapshot) {
        return Container(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(appbarColorSnapshot.data ?? 0),
              title: Text("Generated settings demo"),
              actions: <Widget>[
                _buildPickerDialogAction(context),
              ],
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
          ),
        );
      },
    );
  }

  Widget _buildPickerDialogAction(BuildContext context) => IconButton(
      icon: new Icon(Icons.colorize),
      tooltip: 'Change appbar color',
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: pickerColor,
                      onColorChanged: (color) =>
                          settings.appbarColor = color.value,
                      enableLabel: true,
                      pickerAreaHeightPercent: 0.8,
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]),
        );
      });
}
