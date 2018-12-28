import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';

final _defaultValueChecker = const TypeChecker.fromRuntime(DefaultValue);

DartObject defaultValueAnnotation(FieldElement element) =>
    _defaultValueChecker.firstAnnotationOfExact(element) ??
    (element.getter == null
        ? null
        : _defaultValueChecker.firstAnnotationOfExact(element.getter));

ConstructorBuilder generateBasicConstructor(
    ConstructorBuilder builder, List<FieldElement> fields) {
  var code = '';
  code += fields.map((f) {
    var annotation = defaultValueAnnotation(f);

    if (annotation != null) {
      var fieldCode =
          "this._cache[\"${f.name}\"] = '${annotation.getField("value").toStringValue()}';";
      return fieldCode;
    }
  }).join('\n');
  return builder
    ..initializers.add(Code("this._adapter = adapter"))
      ..body = Code(code)
    ..requiredParameters.add(
      Parameter((b) => b
        ..type = refer('PreferenceAdapter')
        ..name = 'adapter'),
    );
}
String getDefaultValue(FieldElement field, DartObject annotation) {
  var value;
  switch (field.type.displayName) {
    case 'bool':
      value = annotation.getField("value").toBoolValue().toString();
      break;
    case 'int':
      value = annotation.getField("value").toIntValue().toString();
      break;
    case 'String':
      value = "'" + annotation.getField("value").toStringValue() + "'";
      break;
    case 'List<String>':
      value = annotation.getField("value").toListValue().toString();
      break;
    case 'double':
      value = annotation.getField("value").toDoubleValue().toString();
      break;
  }
  return value;
}
ClassBuilder generateClassBuilder(ClassElement element,
    {Constructor injectedConstructor}) {
  return ClassBuilder()
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
      injectedConstructor ??
          Constructor((b) => generateBasicConstructor(b, element.fields)),
    )
    ..methods.addAll(element.fields.map<Method>(generateAsyncGetter))
    ..methods.addAll(element.fields.map<Method>(generateAsyncSetter))
    ..methods.addAll(element.fields.map<Method>(generateSetter))
    ..methods.addAll(element.fields.map<Method>(generateGetter));
}

String setterCodeForField(FieldElement field, {bool private = true}) {
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

String cacheGetterCodeForField(FieldElement field) {
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

String asyncGetterCodeForField(FieldElement field, {bool returns = true}) {
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

Method generateSetter(FieldElement field) {
  String code = setterCodeForField(field);

  code += '\n _cache["${field.name}"] = value;';
  return Method((b) => b
    ..name = field.name
    ..body = Code(code)
    ..requiredParameters.add(Parameter((b) => b
      ..name = 'value'
      ..type = refer(field.type.displayName)))
    ..type = MethodType.setter);
}

Method generateGetter(FieldElement field) {
  Code code = Code(cacheGetterCodeForField(field));

  return Method((b) => b
    ..name = field.name
    ..body = code
    ..returns = refer(field.type.displayName)
    ..type = MethodType.getter);
}

Method generateAsyncGetter(FieldElement field) {
  Code code = Code(asyncGetterCodeForField(field));

  return Method((b) => b
    ..name = "${field.name}Async"
    ..body = code
    ..returns = refer("Future<${field.type.displayName}>"));
}

Method generateAsyncSetter(FieldElement field, {bool returns = true}) {
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
