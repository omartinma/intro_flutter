import 'package:flutter/material.dart';

class CharactersLoadingView extends StatelessWidget {
  const CharactersLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
