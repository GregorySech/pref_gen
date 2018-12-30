# pref_gen

Generator to create boilerplate for shared preferences based on a provided interface.  
The generated code is platform agnostic, there's an adapter interface inside the pref_gen_annotations package that can be used to inject an implementation based on the platform project.   
This choice was made to give developers the ability to model persistance rapidly into packages shared between Flutter and Web apps.

## Usage

Suppose the shared model package is called A and B the platform specific annotation.

1. Add this package as a dev dependency to your `A/pubspec.yaml`.
2. Add `pref_gen_annotations` as a dependency to your `A/pubspec.yaml`
3. Annotate classes with the PreferencesHolder (or the ReactivePreferencesHolder) annotation.
4. Run `pub run build_runner build` to start the code generation.
5. Comsume the generated code into the `A` package.
6. Add `pref_gen_flutter` in `B/pubspec.yaml` and inject from `B` the implementation of the adapter for Flutter into the model.
7. Consume the model into the views.
