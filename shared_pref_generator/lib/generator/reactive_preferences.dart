import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:shared_pref_generator/generator/generator.dart';

Builder reactiveSharedPreferencesGenerator(BuilderOptions options) {
  return SharedPartBuilder([ReactiveSharedPreferencesGenerator()],
      "reactive_shared_preferences_generator");
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
              (generateBasicConstructor(ConstructorBuilder())
                    ..body = Block((b) => b
                      ..statements.addAll(element.fields.map<Code>((field) => Code(
                          '${field.name}Sink = (StreamController<${field.type.displayName}>.broadcast()'
                          '..stream.listen((value) async {'
                          'await ${setterCodeForField(field, private: false)}'
                          '_${field.name}Subject.add(value);'
                          ' }))'
                          '.sink;')))
                      ..statements.addAll(element.fields.map((field) => Code(
                          '${asyncGetterCodeForField(field, returns: false)}.then(${field.name}Sink.add);')))))
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
      return (DartFormatter().format('${generatedClass.accept(emitter)}') +
          '\n' +
          generateAbstractClass(element));
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

String generateAbstractClass(ClassElement element) {
  final generatedClass = ClassBuilder()
    ..abstract = true
    ..name = "${element.name}Preferences"
    ..methods.addAll(element.fields.map((field) => Method((b) => b
      ..name = '${field.name}Stream'
      ..returns = refer('Stream<${field.type.displayName}>')
      ..type = MethodType.getter)))
    ..fields.addAll(element.fields.map((field) => Field((b) => b
      ..name = '${field.name}Sink'
      ..type = refer('Sink<${field.type.displayName}>'))));
  final emitter = DartEmitter();
  return (DartFormatter().format('${generatedClass.build().accept(emitter)}'));
}
