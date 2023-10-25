import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import 'package:test/test.dart';

import 'responses.dart';

class _MockHttpClient extends Mock implements Client {}

class _MockResponse extends Mock implements Response {}

class _FakeUri extends Fake implements Uri {}

void main() {
  group('RickAndMortyApi', () {
    late _MockHttpClient httpClient;
    late RickAndMortyApi api;
    const baseUrl = 'rickandmortyapi.com';

    setUpAll(() {
      registerFallbackValue(_FakeUri());
    });

    setUp(() {
      httpClient = _MockHttpClient();
      api = RickAndMortyApi(httpClient: httpClient);
    });

    group('getCharacters', () {
      test('returns list of character if request succeeds', () {
        final response = _MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(validCharacterResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          api.getCharacters(),
          completion(
            isA<List<Character>>()
                .having((r) => r.length, 'length', greaterThan(0)),
          ),
        );
      });

      test('throws HttpErrorResponse if status code is not 200', () async {
        final response = _MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          api.getCharacters(),
          throwsA(isA<HttpErrorResponse>()),
        );
      });

      test('throws HttpMalformedResponse on invalid json', () async {
        final response = _MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          api.getCharacters(),
          throwsA(isA<HttpMalformedResponse>()),
        );
      });

      test('throws HttpMalformedResponse on empty response', () async {
        final response = _MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          api.getCharacters(),
          throwsA(isA<HttpMalformedResponse>()),
        );
      });

      test(
          'throws HttpMalformedResponse if response body does not '
          'contain characters key', () async {
        final response = _MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"test": "test"}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          api.getCharacters(),
          throwsA(isA<HttpMalformedResponse>()),
        );
      });
    });
  });
}
