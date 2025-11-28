import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/character.dart';

class HptrackerApiService {
    var baseUrl = 'http://192.168.0.39:5006/api/characters';

  
    Future<List<Character>> getCharacters() async {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
                List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load characters");
      }
    }

    Future<Character> getCharacterById(int id) async {

      final response = await http.get(Uri.parse('$baseUrl/$id'));  

      if (response.statusCode == 200) {
        return Character.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Character');
      }
    }

    Future<Character> patchCharacterById(int id, Character character) async {
      final url = Uri.parse('$baseUrl/$id');
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};

      final response = await http.patch(url, headers: headers, body: jsonEncode(character.toJson()));

      if (response.statusCode == 204) {
        return character;
      } else {
        throw Exception('Failed to update character');
      }
    } 

}