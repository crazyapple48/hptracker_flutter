
import 'package:hptracker_flutter/data/services/hptracker_api_service.dart';
import 'package:hptracker_flutter/domain/models/character.dart';

class CharacterRepository {

  final HptrackerApiService apiService;

  CharacterRepository({
    required this.apiService,
  });

  Future<List<Character>> getCharacters() async {
    try {
      final result = await apiService.getCharacters();
      return result;
    } on Exception catch (e) {
      throw Exception("Something failed fetching character list $e");
    }
  }

  Future<Character> getCharacter(int id) async {
    try {
      final result = await apiService.getCharacterById(id);
      
      return result;
    } on Exception  catch (e) {
      throw Exception ("Something failed fetching Character $e");
    }
  }
}