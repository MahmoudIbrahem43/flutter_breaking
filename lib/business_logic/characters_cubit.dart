import 'package:bloc/bloc.dart';
import 'package:flutter_breaking/data/models/character.dart';
import 'package:flutter_breaking/data/models/qoutes.dart';
import 'package:flutter_breaking/data/repo/characters_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepo charactersRepo;
  List<Character> characters;

  CharactersCubit(this.charactersRepo) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepo.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName) {
    charactersRepo.getCharactersQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
