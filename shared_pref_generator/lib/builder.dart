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
        methods.add(_generateGetter(field));
        methods.add(_generateSetter(field));
      });

      final generatedClass = Class(
        (b) => b
          ..fields.add(Field((b) => b
            ..name = '_adapter'
            ..modifier = FieldModifier.var$
            ..type = refer('PreferenceAdapter')))
          ..name = "_\$${element.name}"
          ..implements.add(refer(element.name))
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
    return "// ANNOTATION FOUND";
  }

  Method _generateSetter(FieldElement field) {
    Code code;
    switch (field.type.displayName) {
      case 'bool':
        code = Code('_adapter.setBool("${field.name}", value);');
        break;
      case 'int':
        code = Code('_adapter.setInt("${field.name}", value);');
        break;
      case 'String':
        code = Code('_adapter.setString("${field.name}", value);');
        break;
      case 'List<String>':
        code = Code('_adapter.setStringList("${field.name}", value);');
        break;
      case 'double':
        code = Code('_adapter.setDouble("${field.name}", value);');
        break;
    }

    return Method((b) => b
      ..name = field.name
      ..body = code
      ..requiredParameters.add(Parameter((b) => b
        ..name = 'value'
        ..type = refer(field.type.displayName)))
      ..type = MethodType.setter);
  }

  Method _generateGetter(FieldElement field) {
    Code code;
    switch (field.type.displayName) {
      case 'bool':
        code = Code('return false;');
        break;
      case 'int':
        code = Code('return 0;');
        break;
      case 'String':
        code = Code('return "ddd";');
        break;
      case 'List<String>':
        code = Code('return [];');
        break;
      case 'double':
        code = Code('return 0;');
        break;
    }

    return Method((b) => b
      ..name = field.name
      ..body = code
      ..returns = refer(field.type.displayName)
      ..type = MethodType.getter);
  }
  
}
