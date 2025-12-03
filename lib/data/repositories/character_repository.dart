import 'package:hptracker_flutter/data/services/hptracker_api_service.dart';
import 'package:hptracker_flutter/models/character.dart';

class CharacterRepository {
  final HptrackerApiService apiService;

  CharacterRepository({required this.apiService});

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
    } on Exception catch (e) {
      throw Exception("Something failed fetching Character $e");
    }
  }

  Future<Character> updateCharacterById(int? id, Character character) async {
    try {
      final result = await apiService.patchCharacterById(id!, character);

      return result;
    } on Exception catch (e) {
      throw Exception("Something went wrong updating... $e");
    }
  }

  Future<void> createCharacter(Character character) async {
    try {
      final result = await apiService.postCharacter(character);

      return result;
    } on Exception catch (e) {
      throw Exception("Something went wrong creating... $e");
    }
  }

  Future<void> deleteCharacter(int id) async {
    try {
      await apiService.deleteCharacterById(id);
    } on Exception {
      rethrow;
    }
  }
}
