import 'package:rick_and_morty_api/rick_and_morty_api.dart';

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
      return charactersApi;
    } catch (_) {
      throw GetCharactersFailure();
    }
  }
}
