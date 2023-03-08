import 'package:flutter/material.dart';
import 'package:intro_flutter/character_details/character_details.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class CharactersLoadedView extends StatelessWidget {
  const CharactersLoadedView({
    required this.characters,
    super.key,
  });

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
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push<void>(
        CharacterDetailsPage.route(character),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'image_hero_${character.name}',
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(character.image),
              ),
            ),
          ),
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
      ),
    );
  }
}
