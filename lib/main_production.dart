// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:character_repository/character_repository.dart';
import 'package:intro_flutter/app/view/app.dart';
import 'package:intro_flutter/bootstrap.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

void main() {
  final rickAndMortyApi = RickAndMortyApi();
  final characterRepository = CharacterRepository(
    rickAndMortyApi: rickAndMortyApi,
  );

  bootstrap(
    () => App(
      characterRepository: characterRepository,
    ),
  );
}
