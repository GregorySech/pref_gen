import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:shared_pref_annotation/shared_pref_annotation.dart';

Builder sharedPreferencesGenerator(BuilderOptions options) {
  return SharedPartBuilder([SharedPreferenecesGenerator()], "shared_preferences_generator");
}

class SharedPreferenecesGenerator extends GeneratorForAnnotation<PreferencesHolder> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    print("AAAAA");
    return "// ANNOTATION FOUND";
  }
}