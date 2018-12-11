import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:shared_pref_annotation/shared_pref_annotation.dart';

Builder sharedPreferencesGenerator(BuilderOptions options) {
  print("IN THE FACTORY BOIS");
  return SharedPartBuilder([SharedPreferenecesGenerator()], "shared_preferences_generator");
}

class SharedPreferenecesGenerator extends GeneratorForAnnotation<PreferencesHolder> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
<<<<<<< HEAD
    print("AAA");
    if(element is ClassElement) {
      var fieldImpls = element.fields.map(
        (field) {
          return "// ${field.name} ${field.type}";
=======
    if(element is ClassElement) {
      
      var fieldImpls = element.fields.map(
        (field) {
          return "//" + field.name;
>>>>>>> ba3205de7206fdf349b8eb03d430efa8cfffc9d7
        }
      );

      return fieldImpls.join('\n');
    }
    print(element.name);
    return "// ANNOTATION FOUND";
  }
}