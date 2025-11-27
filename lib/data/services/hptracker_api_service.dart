import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/character.dart';

class HptrackerApiService {
    
    Future<Character> getCharacterById(int id) async {

      final response = await http.get(Uri.parse('http://localhost:5006/api/characters/22'));  

      if (response.statusCode == 200) {
        return Character.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Character');
      }
    }
}