import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({
    required this.character,
    super.key,
  });

  final Character character;

  static Route<void> route(Character character) {
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
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _CharacterImage(character: character),
              const SizedBox(height: 15),
              _CharacterName(name: character.name),
              _Status(status: character.status),
              const SizedBox(height: 15),
              _Species(species: character.species),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  const _CharacterImage({
    required this.character,
  });
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
                image: NetworkImage(character.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CharacterName extends StatelessWidget {
  const _CharacterName({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({
    required this.status,
  });

  final Status status;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case Status.alive:
        color = Colors.green;
      case Status.dead:
        color = Colors.red;
      case Status.unknown:
        color = Colors.yellow;
    }
    return Chip(
      label: Text(
        status.toString(),
        style: const TextStyle(fontSize: 23),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.all(15),
    );
  }
}

class _Species extends StatelessWidget {
  const _Species({
    required this.species,
  });

  final String species;

  @override
  Widget build(BuildContext context) {
    return Text(
      species,
      style: const TextStyle(fontSize: 23),
    );
  }
}
