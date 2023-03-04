// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:intro_flutter/characters/characters.dart';

void main() {
  group('CharactersEvent', () {
    group('CharactersFetchRequested', () {
      test('support value equality', () {
        final instanceA = CharactersFetchRequested();
        final instanceB = CharactersFetchRequested();
        expect(instanceA, equals(instanceB));
      });
    });
  });
}
