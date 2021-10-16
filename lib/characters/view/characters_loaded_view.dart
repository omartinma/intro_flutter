import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';

class CharactersLoadedView extends StatelessWidget {
  const CharactersLoadedView({
    Key? key,
    required this.characters,
  }) : super(key: key);

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => CharacterItemView(
        character: characters[index],
      ),
      itemCount: characters.length,
    );
  }
}

class CharacterItemView extends StatelessWidget {
  const CharacterItemView({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(character.image),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.white70,
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                character.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
