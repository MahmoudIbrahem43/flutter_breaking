import 'package:flutter_breaking/data/models/character.dart';
import 'package:flutter_breaking/data/models/qoutes.dart';
import 'package:flutter_breaking/data/web_services/character_web_service.dart';

class CharactersRepo {
  final CharacterWebService characterWebService;

  CharactersRepo(this.characterWebService);

  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebService.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharactersQuotes(String charName) async {
    final quotes = await characterWebService.getCharactersQuotes(charName);
    return quotes.map((charaQuote) => Quote.fromJson(charaQuote)).toList();
  }
}
