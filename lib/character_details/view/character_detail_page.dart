import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Column(
          children: [
            _CharacterImage(character: character),
            const SizedBox(
              height: 15,
            ),
            _CharacterName(name: character.name),
          ],
        ),
      ),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  const _CharacterImage({Key? key, required this.character}) : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'image_hero_${character.name}',
        child: AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(character.image), fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}

class _CharacterName extends StatelessWidget {
  const _CharacterName({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }
}
