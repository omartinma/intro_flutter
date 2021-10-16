import 'dart:convert';
import 'package:http/http.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

/// {@template rick_and_morty_api}
/// Rick And Morty API
/// {@endtemplate}
class RickAndMortyApi {
  /// {@macro rick_and_morty_api}
  RickAndMortyApi({Client? httpClient}) : _httpClient = httpClient ?? Client();

  final Client _httpClient;
  static const _baseUrl = 'rickandmortyapi.com';

  /// Return List of [Character]
  Future<List<Character>> getCharacters() async {
    const endpoint = 'api/character';
    final url = Uri.https(_baseUrl, endpoint);
    final response = await _httpClient.get(url);

    if (response.statusCode != 200) {
      throw HttpErrorResponse(
        url: url,
        statusCode: response.statusCode,
      );
    }

    try {
      final Map<String, dynamic> charactersJson = jsonDecode(response.body);
      final characters = (charactersJson['results'] as List)
          .map(
            (e) => Character.fromJson(e),
          )
          .toList();
      return characters;
    } catch (e) {
      throw HttpMalformedResponse();
    }
  }
}
