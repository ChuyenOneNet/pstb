// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steps_foot_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StepsFootStore on _StepsFootStoreBase, Store {
  late final _$stepsAtom =
      Atom(name: '_StepsFootStoreBase.steps', context: context);

  @override
  String get steps {
    _$stepsAtom.reportRead();
    return super.steps;
  }

  @override
  set steps(String value) {
    _$stepsAtom.reportWrite(value, super.steps, () {
      super.steps = value;
    });
  }

  @override
  String toString() {
    return '''
steps: ${steps}
    ''';
  }
}
