// ignore_for_file: prefer_const_constructors
import 'package:character_repository/character_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import 'package:test/test.dart';

class MockRickAndMortyApi extends Mock implements RickAndMortyApi {}

void main() {
  group('CharacterRepository', () {
    late RickAndMortyApi rickAndMortyApi;
    late CharacterRepository characterRepository;

    setUp(() {
      rickAndMortyApi = MockRickAndMortyApi();
      characterRepository = CharacterRepository(
        rickAndMortyApi: rickAndMortyApi,
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CharacterRepository(rickAndMortyApi: rickAndMortyApi),
          isNotNull,
        );
      });
    });

    group('getCharacters', () {
      const characterApi = Character(
        id: 1,
        name: 'name',
        image: 'image',
        species: 'species',
        status: Status.alive,
      );

      setUp(() {
        when(() => rickAndMortyApi.getCharacters())
            .thenAnswer((_) async => [characterApi]);
      });

      test('makes correct request', () async {
        await characterRepository.getCharacters();
        verify(() => rickAndMortyApi.getCharacters()).called(1);
      });

      test('throws GetCharactersFailure when getCharacters fails', () async {
        final exception = Exception('oops');
        when(() => rickAndMortyApi.getCharacters()).thenThrow(exception);
        expect(
          () async => characterRepository.getCharacters(),
          throwsA(isA<GetCharactersFailure>()),
        );
      });

      test('returns correct characters on success', () async {
        final actual = await characterRepository.getCharacters();
        expect(actual, [characterApi]);
      });
    });
  });
}
