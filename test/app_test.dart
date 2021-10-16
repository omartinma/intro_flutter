import 'package:character_repository/character_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intro_flutter/app/app.dart';
import 'package:intro_flutter/characters/characters.dart';
import 'package:mocktail/mocktail.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  group('App', () {
    late CharacterRepository characterRepository;

    setUp(() {
      characterRepository = MockCharacterRepository();
    });

    testWidgets('renders CharactersPage', (tester) async {
      await tester.pumpWidget(
        App(characterRepository: characterRepository),
      );
      expect(find.byType(CharactersPage), findsOneWidget);
    });
  });
}
