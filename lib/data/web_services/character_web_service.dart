import 'package:dio/dio.dart';
import 'package:flutter_breaking/constants/strings.dart';

class CharacterWebService {
  Dio dio;

  CharacterWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response =
          await dio.get('characters'); //charachters => which end of the url
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());  //testing
      return [];
    }
  }

  Future<List<dynamic>> getCharactersQuotes(String charName) async {
    try {
      Response response = await dio.get('quote', queryParameters: {
        'author': charName
      }); //charachters => which end of the url
      print(response.data.toString()); //for testing
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
