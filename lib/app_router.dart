import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/data/repo/characters_repo.dart';
import 'package:flutter_breaking/data/web_services/character_web_service.dart';
import 'package:flutter_breaking/presentation/screens/character_screen.dart';
import 'package:flutter_breaking/presentation/screens/characters_detailes_screen.dart';
import 'business_logic/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character.dart';

class AppRouter {
  CharactersRepo charactersRepo;
  CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepo = CharactersRepo(CharacterWebService());
    charactersCubit = CharactersCubit(charactersRepo);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            //make provider on the top of screen..characterScreen
            create: (BuildContext context) => charactersCubit, //create cupbit
            child: CharacterScreen(),
          ),
        );

      case characterDetailesScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (BuildContext context) =>
                    charactersCubit, //new odbject of cubit
                child: CharacterDetailesScreen(character: character)));
    }
  }
}
