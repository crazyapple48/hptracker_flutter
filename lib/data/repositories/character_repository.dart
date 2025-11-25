import 'package:hptracker_flutter/domain/models/character.dart';

class CharacterRepository {
  Character getCharacter() {
    return Character(
      name: "Max", 
      currentHp: 25, 
      maxHp: 25, 
      currentTempHp: 10, 
      maxTempHp: 10, 
      currentHitDice: 10, 
      maxHitDice: 10);
  }
}