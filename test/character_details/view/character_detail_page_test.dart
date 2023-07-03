import 'package:flutter_test/flutter_test.dart';
import 'package:intro_flutter/character_details/character_details.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('CharacterDetailsPage', () {
    testWidgets('alive displays correctly', (tester) async {
      const character = Character(
        id: 1,
        name: 'name',
        image: 'image',
        species: 'species',
        status: Status.alive,
      );
      await tester.pumpApp(const CharacterDetailsPage(character: character));
      expect(find.byType(CharacterDetailsPage), findsOneWidget);
    });

    testWidgets('dead displays correctly', (tester) async {
      const character = Character(
        id: 1,
        name: 'name',
        image: 'image',
        species: 'species',
        status: Status.dead,
      );
      await tester.pumpApp(const CharacterDetailsPage(character: character));
      expect(find.byType(CharacterDetailsPage), findsOneWidget);
    });

    testWidgets('unknown displays correctly', (tester) async {
      const character = Character(
        id: 1,
        name: 'name',
        image: 'image',
        species: 'species',
        status: Status.unknown,
      );
      await tester.pumpApp(const CharacterDetailsPage(character: character));
      expect(find.byType(CharacterDetailsPage), findsOneWidget);
    });
  });
}
