import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import 'package:test/test.dart';

import 'responses.dart';

class MockHttpClient extends Mock implements Client {}

class MockResponse extends Mock implements Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('RickAndMortyApi', () {
    late MockHttpClient httpClient;
    late RickAndMortyApi api;
    const baseUrl = 'rickandmortyapi.com';
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });
    group('getCharacters', () {
      const endpoint = 'api/character';

      setUp(() {
        httpClient = MockHttpClient();
        api = RickAndMortyApi(httpClient: httpClient);
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(validCharacterResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
      });

      test('makes correct http request', () async {
        final request = Uri.https(
          baseUrl,
          endpoint,
        );
        await api.getCharacters();
        verify(() => httpClient.get(request)).called(1);
      });

      test('returns list of character if request succeeds', () {
        expect(
          api.getCharacters(),
          completion(
            isA<List<Character>>()
                .having((r) => r.length, 'length', greaterThan(0)),
          ),
        );
      });

      test('throws HttpErrorResponse if status code is not 200', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          api.getCharacters(),
          throwsA(isA<HttpErrorResponse>()),
        );
      });

      test('throws HttpMalformedResponse on invalid json', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          api.getCharacters(),
          throwsA(isA<HttpMalformedResponse>()),
        );
      });

      test('throws HttpMalformedResponse on empty response', () async {
        final response = MockResponse();
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
          'contain products key', () async {
        final response = MockResponse();
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
