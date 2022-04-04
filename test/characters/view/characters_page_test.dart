// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intro_flutter/character_details/character_details.dart';
import 'package:intro_flutter/characters/characters.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import '../../helpers/helpers.dart';

class MockCharactersBloc extends MockBloc<CharactersEvent, CharactersState>
    implements CharactersBloc {}

class FakeCharactersEvent extends Fake implements CharactersEvent {}

class FakeCharactersState extends Fake implements CharactersState {}

void main() {
  group('CharactersPage', () {
    testWidgets('displays a CharactersView', (tester) async {
      await tester.pumpApp(
        CharactersPage(),
      );
      await tester.pump();
      expect(find.byType(CharactersView), findsOneWidget);
    });
  });

  group('CharactersView', () {
    late CharactersBloc charactersBloc;
    const characterApi = Character(
      id: 1,
      name: 'name',
      image: 'image',
      species: 'species',
      status: Status.alive,
    );
    const characters = [characterApi];

    setUp(() {
      charactersBloc = MockCharactersBloc();
      when(() => charactersBloc.state).thenReturn(CharactersState());
    });

    testWidgets('displays CharactersErrorView when there is an error',
        (tester) async {
      when(() => charactersBloc.state).thenReturn(
        CharactersState(status: CharactersStatus.failure),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: charactersBloc,
          child: CharactersView(),
        ),
      );
      await tester.pump();
      expect(find.byType(CharactersErrorView), findsOneWidget);
    });

    testWidgets('displays CharactersLoadedView when loads correctly',
        (tester) async {
      when(() => charactersBloc.state).thenReturn(
        CharactersState(
          status: CharactersStatus.success,
          characters: characters,
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: charactersBloc,
          child: CharactersView(),
        ),
      );
      await tester.pump();
      expect(find.byType(CharactersLoadedView), findsOneWidget);
    });

    testWidgets('navigates to character details when clicking on character',
        (tester) async {
      when(() => charactersBloc.state).thenReturn(
        CharactersState(
          status: CharactersStatus.success,
          characters: characters,
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: charactersBloc,
          child: CharactersView(),
        ),
      );
      await tester.pump();
      expect(find.byType(CharactersLoadedView), findsOneWidget);
      await tester.tap(find.byType(CharacterItemView));
      await tester.pumpAndSettle();
      expect(find.byType(CharactersLoadedView), findsNothing);
      expect(find.byType(CharacterDetailsPage), findsOneWidget);
    });
  });
}
