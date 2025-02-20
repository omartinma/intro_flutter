import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intro_flutter/character_details/character_details.dart';
import 'package:intro_flutter/characters/characters.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CharactersLoadedView', () {
    testWidgets(
      'renders grid with characters',
      (WidgetTester tester) async {
        await tester.pumpApp(
          const Scaffold(
            body: CharactersLoadedView(
              characters: [
                Character(
                  id: 1,
                  name: 'name',
                  image: 'image',
                  species: 'species',
                  status: Status.alive,
                ),
              ],
            ),
          ),
        );
        await tester.tap(find.byType(CharacterItemView));
        await tester.pumpAndSettle();
        expect(find.byType(CharactersLoadedView), findsNothing);
        expect(find.byType(CharacterDetailsPage), findsOneWidget);
      },
    );
  });
}
