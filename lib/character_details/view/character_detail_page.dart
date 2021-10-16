import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({Key? key, required this.character})
      : super(key: key);

  final Character character;

  static Route route(Character character) {
    return MaterialPageRoute<void>(
      builder: (context) => CharacterDetailsPage(character: character),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Hero(
            tag: 'image_hero_${character.name}',
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                character.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
