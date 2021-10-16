part of 'characters_bloc.dart';

enum CharactersStatus {
  loading,
  success,
  failure,
}

class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.loading,
    this.characters = const [],
  });

  final List<Character> characters;
  final CharactersStatus status;

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
    );
  }

  @override
  List<Object> get props => [characters, status];
}
