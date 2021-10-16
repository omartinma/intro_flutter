import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()

/// [Character] is a character entity fetched from rick and morty api
class Character {
  /// Default constructor
  const Character({
    required this.id,
    required this.name,
    required this.image,
  });

  /// Json deserialize
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// Id of the character
  final int id;

  /// Name of the character
  final String name;

  /// Image of the character
  final String image;
}
