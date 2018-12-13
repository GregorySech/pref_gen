import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:source_gen/source_gen.dart';

Builder sharedPreferencesGenerator(BuilderOptions options) {
  return SharedPartBuilder(
      [SharedPreferenecesGenerator()], "shared_preferences_generator");
}

Builder reactiveSharedPreferencesGenerator(BuilderOptions options) {
  return SharedPartBuilder([ReactiveSharedPreferencesGenerator()],
      "reactive_shared_preferences_generator");
}

class SharedPreferenecesGenerator
    extends GeneratorForAnnotation<PreferencesHolder> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      final generatedClass = _generateClassBuilder(element).build();
      final emitter = DartEmitter();
      return (DartFormatter().format('${generatedClass.accept(emitter)}'));
    }
    return "// Annotation found but it's not annotating a class";
  }
}

class ReactiveSharedPreferencesGenerator
    extends GeneratorForAnnotation<ReactivePreferencesHolder> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      final generatedClass = (ClassBuilder()
            ..fields.add(Field((b) => b
              ..name = '_adapter'
              ..modifier = FieldModifier.final$
              ..type = refer('PreferenceAdapter')))
            ..name = "_\$${element.name}"
            ..implements.add(refer(element.name))
            ..constructors.add(
              (_generateBasicConstructor(ConstructorBuilder())
                    ..body = Block((b) => b
                      ..statements.addAll(element.fields.map<Code>((field) => Code(
                          '${field.name}Sink = (StreamController<${field.type.displayName}>.broadcast()'
                          '..stream.listen((value) async {'
                          'await ${_setterCodeForField(field, private: false)}'
                          '_${field.name}Subject.add(value);'
                          ' }))'
                          '.sink;')))
                      ..statements.addAll(element.fields.map((field) => Code(
                          '${_asyncGetterCodeForField(field, returns: false)}.then(${field.name}Sink.add);')))))
                  .build(),
            )
            ..fields
                .addAll(element.fields.map<Field>(_generateBehaviourSubject))
            ..fields.addAll(element.fields.map<Field>(_generateSink))
            ..methods.addAll(element.fields.map(_generateStreamGetter))
            ..methods.add(Method.returnsVoid((m) => m
              ..name = 'dispose'
              ..body = Block.of(element.fields
                  .map((field) => Code('${field.name}Sink.close();'))))))
          .build();
      final emitter = DartEmitter();
      return (DartFormatter().format('${generatedClass.accept(emitter)}'));
    }

    return "// Annotation found but it's not annotating a class";
  }
}

Method _generateStreamGetter(FieldElement element) => Method((b) => b
  ..name = '${element.name}Stream'
  ..returns = refer('Stream<${element.type.displayName}>')
  ..type = MethodType.getter
  ..lambda = true
  ..body = Code('_${element.name}Subject.asBroadcastStream()'));

Field _generateBehaviourSubject(FieldElement element) {
  return Field((b) => b
    ..name = '_${element.name}Subject'
    ..type = refer('BehaviorSubject<${element.type.displayName}>')
    ..assignment = Code('BehaviorSubject<${element.type.displayName}>()')
    ..modifier = FieldModifier.final$);
}

Field _generateSink(FieldElement element) {
  return Field((b) => b
    ..name = '${element.name}Sink'
    ..type = refer('Sink<${element.type.displayName}>'));
}

ConstructorBuilder _generateBasicConstructor(ConstructorBuilder builder) =>
    builder
      ..initializers.add(const Code('this._adapter = adapter'))
      ..requiredParameters.add(
        Parameter((b) => b
          ..type = refer('PreferenceAdapter')
          ..name = 'adapter'),
      );

ClassBuilder _generateClassBuilder(ClassElement element,
        {Constructor injectedConstructor}) =>
    ClassBuilder()
      ..fields.add(Field((b) => b
        ..name = '_cache'
        ..type = refer('Map<String, dynamic>')
        ..modifier = FieldModifier.final$
        ..assignment = Code('Map<String, dynamic>()')))
      ..fields.add(Field((b) => b
        ..name = '_adapter'
        ..modifier = FieldModifier.final$
        ..type = refer('PreferenceAdapter')))
      ..name = "_\$${element.name}"
      ..implements.add(refer(element.name))
      ..constructors.add(
        injectedConstructor ?? Constructor(_generateBasicConstructor),
      )
      ..methods.addAll(element.fields.map<Method>(_generateAsyncGetter))
      ..methods.addAll(element.fields.map<Method>(_generateAsyncSetter))
      ..methods.addAll(element.fields.map<Method>(_generateSetter))
      ..methods.addAll(element.fields.map<Method>(_generateGetter));

String _setterCodeForField(FieldElement field, {bool private = true}) {
  switch (field.type.displayName) {
    case 'bool':
      return '${private ? '_' : ''}adapter.setBool("${field.name}", value);';
    case 'int':
      return '${private ? '_' : ''}adapter.setInt("${field.name}", value);';
    case 'String':
      return '${private ? '_' : ''}adapter.setString("${field.name}", value);';
    case 'List<String>':
      return '${private ? '_' : ''}adapter.setStringList("${field.name}", value);';
    case 'double':
      return '${private ? '_' : ''}adapter.setDouble("${field.name}", value);';
  }
}

String _cacheGetterCodeForField(FieldElement field) {
  switch (field.type.displayName) {
    case 'bool':
      return 'return _cache["${field.name}"] as bool;';
    case 'int':
      return 'return _cache["${field.name}"] as int;';
    case 'String':
      return 'return _cache["${field.name}"] as String;';
    case 'List<String>':
      return 'return List<String>.from(_cache["${field.name}"] as List);';
    case 'double':
      return 'return _cache["${field.name}"] as double;';
  }
}

String _asyncGetterCodeForField(FieldElement field, {bool returns = true}) {
  switch (field.type.displayName) {
    case 'bool':
      return '${returns ? 'return ' : ''}_adapter.getBool("${field.name}")${returns ? ';' : ''}';
    case 'int':
      return '${returns ? 'return ' : ''}_adapter.getInt("${field.name}")${returns ? ';' : ''}';
    case 'String':
      return '${returns ? 'return ' : ''}_adapter.getString("${field.name}")${returns ? ';' : ''}';
    case 'List<String>':
      return '${returns ? 'return ' : ''}_adapter.getStringList("${field.name}")${returns ? ';' : ''}';
    case 'double':
      return '${returns ? 'return ' : ''}_adapter.getDouble("${field.name}")${returns ? ';' : ''}';
  }
}

Method _generateSetter(FieldElement field) {
  String code = _setterCodeForField(field);

  code += '\n _cache["${field.name}"] = value;';
  return Method((b) => b
    ..name = field.name
    ..body = Code(code)
    ..requiredParameters.add(Parameter((b) => b
      ..name = 'value'
      ..type = refer(field.type.displayName)))
    ..type = MethodType.setter);
}

Method _generateGetter(FieldElement field) {
  Code code = Code(_cacheGetterCodeForField(field));

  return Method((b) => b
    ..name = field.name
    ..body = code
    ..returns = refer(field.type.displayName)
    ..type = MethodType.getter);
}

Method _generateAsyncGetter(FieldElement field) {
  Code code = Code(_asyncGetterCodeForField(field));

  return Method((b) => b
    ..name = "${field.name}Async"
    ..body = code
    ..returns = refer("Future<${field.type.displayName}>"));
}

Method _generateAsyncSetter(FieldElement field, {bool returns = true}) {
  String code = '_cache["${field.name}"] = value; \n';
  switch (field.type.displayName) {
    case 'bool':
      code +=
          '${returns ? 'return ' : ''} _adapter.setBool("${field.name}", value);';
      break;
    case 'int':
      code +=
          '${returns ? 'return ' : ''} _adapter.setInt("${field.name}", value);';
      break;
    case 'String':
      code +=
          '${returns ? 'return ' : ''} _adapter.setString("${field.name}", value);';
      break;
    case 'List<String>':
      code +=
          '${returns ? 'return ' : ''} _adapter.setStringList("${field.name}", value);';
      break;
    case 'double':
      code +=
          '${returns ? 'return ' : ''} _adapter.setDouble("${field.name}", value);';
      break;
  }

  return Method((b) => b
    ..name = "${field.name}AsyncSet"
    ..body = Code(code)
    ..requiredParameters.add(Parameter((b) => b
      ..name = 'value'
      ..type = refer(field.type.displayName)))
    ..returns = refer("Future<void>"));
}
