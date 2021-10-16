import 'package:character_repository/character_repository.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart' hide Character;

/// GetCharactersFailure
class GetCharactersFailure implements Exception {}

/// {@template character_repository}
/// Dart package for the character domain
/// {@endtemplate}
class CharacterRepository {
  /// {@macro character_repository}
  CharacterRepository({
    required RickAndMortyApi rickAndMortyApi,
  }) : _rickAndMortyApi = rickAndMortyApi;

  final RickAndMortyApi _rickAndMortyApi;

  /// Gets the list of all [Character] elements
  Future<List<Character>> getCharacters() async {
    try {
      final charactersApi = await _rickAndMortyApi.getCharacters();
      return charactersApi
          .map(
            (e) => Character(id: e.id, name: e.name, image: e.image),
          )
          .toList();
    } catch (_) {
      throw GetCharactersFailure();
    }
  }
}
