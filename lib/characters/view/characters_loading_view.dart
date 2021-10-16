import 'package:flutter/material.dart';

class CharactersLoadingView extends StatelessWidget {
  const CharactersLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
