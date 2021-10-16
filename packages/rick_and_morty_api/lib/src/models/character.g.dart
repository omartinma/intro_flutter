// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return $checkedNew('Character', json, () {
    final val = Character(
      id: $checkedConvert(json, 'id', (v) => v as int),
      name: $checkedConvert(json, 'name', (v) => v as String),
      image: $checkedConvert(json, 'image', (v) => v as String),
      species: $checkedConvert(json, 'species', (v) => v as String),
      status: $checkedConvert(json, 'status', (v) => v as String),
    );
    return val;
  });
}
