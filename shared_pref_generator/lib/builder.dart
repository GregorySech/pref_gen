import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:shared_pref_annotation/shared_pref_annotation.dart';

Builder sharedPreferencesGenerator(BuilderOptions options) {
  return SharedPartBuilder(
      [SharedPreferenecesGenerator()], "shared_preferences_generator");
}

class SharedPreferenecesGenerator
    extends GeneratorForAnnotation<PreferencesHolder> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      var methods = List<Method>();

      element.fields.forEach((field) {
        methods.add(Method((b) => b
          ..name = field.name
          ..type = MethodType.setter
          ..body = Code('this._adapter.setBool("ddd", true);')));

        methods.add(Method((b) => b
          ..name = field.name
          ..type = MethodType.getter
          ..body = Code('return true;')));
      });

      final generatedClass = Class(
        (b) => b
          ..fields.add(Field((b) => b
            ..name = '_adapter'
            ..modifier = FieldModifier.var$
            ..type = refer('PreferenceAdapter')))
          ..name = "_\$${element.name}"
          ..extend = refer(element.name)
          ..constructors.add(
            Constructor(
              (b) => b
                ..body = const Code('this._adapter = adapter;')
                ..requiredParameters.add(
                  Parameter((b) => b
                    ..type = refer('PreferenceAdapter')
                    ..name = 'adapter'),
                ),
            ),
          )
          ..methods.addAll(methods),
      );

      final emitter = DartEmitter();
      return (DartFormatter().format('${generatedClass.accept(emitter)}'));
    }
    print(element.name);
    return "// ANNOTATION FOUND";
  }
}
