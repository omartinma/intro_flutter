// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:character_repository/character_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intro_flutter/characters/characters.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class _MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  group('CharactersBloc', () {
    late CharacterRepository characterRepository;

    setUp(() {
      characterRepository = _MockCharacterRepository();
    });

    test('initial state is empty', () {
      expect(
        CharactersBloc(
          characterRepository: characterRepository,
        ).state,
        equals(CharactersState()),
      );
    });

    group('CharactersFetchRequested', () {
      const characterApi = Character(
        id: 1,
        name: 'name',
        image: 'image',
        species: 'species',
        status: Status.alive,
      );
      const characters = [characterApi];

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, failure] when getCharacters throws exception',
        setUp: () {
          when(
            () => characterRepository.getCharacters(),
          ).thenThrow(Exception());
        },
        build: () => CharactersBloc(characterRepository: characterRepository),
        act: (bloc) => bloc.add(CharactersFetchRequested()),
        expect: () => [
          CharactersState(),
          CharactersState(status: CharactersStatus.failure),
        ],
      );

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, successful] when getCharacters returns characters',
        setUp: () {
          when(
            () => characterRepository.getCharacters(),
          ).thenAnswer((_) async => characters);
        },
        build: () => CharactersBloc(characterRepository: characterRepository),
        act: (bloc) => bloc.add(CharactersFetchRequested()),
        expect: () => [
          CharactersState(),
          CharactersState(
            status: CharactersStatus.success,
            characters: characters,
          ),
        ],
      );
    });
  });
}
