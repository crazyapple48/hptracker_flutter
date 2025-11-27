import 'dart:convert';

import 'package:hptracker_flutter/domain/models/character.dart';
import 'package:http/http.dart' as http;

class CharacterRepository {


  Future<Character> getCharacter() async {
    final response = await http.get(Uri.parse('http://localhost:5006/api/characters/22'));  

    // Character character = Character (
    //     name: "Max", 
    //     currentHp: 25, 
    //     maxHp: 25, 
    //     currentTempHp: 10, 
    //     maxTempHp: 10, 
    //     currentHitDice: 10, 
    //     maxHitDice: 10
    //   );
    // await Future.delayed(Duration(seconds: 3),);

    if (response.statusCode == 200) {
      return Character.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Character');
    }
  }
}