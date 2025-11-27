import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/character.dart';

class HptrackerApiService {
    
    Future<List<Character>> getCharacters() async {
      final response = await http.get(Uri.parse('http://192.168.0.39:5006/api/characters'));

      if (response.statusCode == 200) {
                List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load characters");
      }
    }

    Future<Character> getCharacterById(int id) async {

      final response = await http.get(Uri.parse('http://192.168.0.39:5006/api/characters/$id'));  

      if (response.statusCode == 200) {
        return Character.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load Character');
      }
    }

}