import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:character_repository/character_repository.dart';
import 'package:equatable/equatable.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({
    required this.characterRepository,
  }) : super(const CharactersState());

  final CharacterRepository characterRepository;

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is CharactersFetchRequested) {
      yield* _mapCharactersFetchRequestedToState(event);
    }
  }

  Stream<CharactersState> _mapCharactersFetchRequestedToState(
    CharactersEvent event,
  ) async* {
    yield state.copyWith(status: CharactersStatus.loading);
    try {
      final characters = await characterRepository.getCharacters();
      yield state.copyWith(
        status: CharactersStatus.success,
        characters: characters,
      );
    } catch (_) {
      yield state.copyWith(status: CharactersStatus.failure);
    }
  }
}
