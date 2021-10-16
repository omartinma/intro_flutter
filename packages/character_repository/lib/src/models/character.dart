import 'package:equatable/equatable.dart';

/// {@template character}
/// [Character] is a model representing a single character.
/// {@endtemplate}
class Character extends Equatable {
  /// {@macro character}
  const Character({
    required this.id,
    required this.name,
    required this.image,
  });

  /// Id of the character
  final int id;

  /// Name of the character
  final String name;

  /// Image of the character
  final String image;

  @override
  List<Object> get props => [id, name, image];
}
