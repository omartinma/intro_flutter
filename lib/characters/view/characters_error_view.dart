import 'package:flutter/material.dart';
import 'package:intro_flutter/l10n/l10n.dart';

class CharactersErrorView extends StatelessWidget {
  const CharactersErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Text(l10n.errorViewMessage),
    );
  }
}
