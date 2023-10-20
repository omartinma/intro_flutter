import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_flutter/characters/characters.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(
        characterRepository: context.read<CharacterRepository>(),
      )..add(CharactersFetchRequested()),
      child: const CharactersView(),
    );
  }
}

@visibleForTesting
class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          return switch (state.status) {
            CharactersStatus.failure => const CharactersErrorView(),
            CharactersStatus.loading => const CharactersLoadingView(),
            CharactersStatus.success =>
              CharactersLoadedView(characters: state.characters)
          };
        },
      ),
    );
  }
}
