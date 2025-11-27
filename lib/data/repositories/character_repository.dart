
import 'package:hptracker_flutter/data/services/hptracker_api_service.dart';
import 'package:hptracker_flutter/domain/models/character.dart';

class CharacterRepository {

  final HptrackerApiService apiService;

  CharacterRepository({
    required this.apiService,
  });


  Future<Character> getCharacter() async {
    try {
      final result = await apiService.getCharacterById(22);
      
      return result;
    } on Exception {
      throw Exception("Something failed fetching Character.");
    }
  }
}