import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:character_repository/character_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({
    required this.characterRepository,
  }) : super(const CharactersState()) {
    on<CharactersFetchRequested>(_fetchRequested);
  }

  final CharacterRepository characterRepository;

  Future<void> _fetchRequested(
    CharactersFetchRequested event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(status: CharactersStatus.loading));
    try {
      final characters = await characterRepository.getCharacters();
      emit(
        state.copyWith(
          status: CharactersStatus.success,
          characters: characters,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }
}
