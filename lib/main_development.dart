// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:character_repository/character_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:intro_flutter/app/app.dart';
import 'package:intro_flutter/app/app_bloc_observer.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  final rickAndMortyApi = RickAndMortyApi();
  final characterRepository = CharacterRepository(
    rickAndMortyApi: rickAndMortyApi,
  );

  runZonedGuarded(
    () => runApp(App(characterRepository: characterRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
