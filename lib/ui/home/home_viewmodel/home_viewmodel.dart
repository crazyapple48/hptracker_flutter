import 'package:flutter/material.dart';
import 'package:hptracker_flutter/data/repositories/character_repository.dart';
import 'package:hptracker_flutter/domain/models/character.dart';

class HomeViewModel extends ChangeNotifier{
  HomeViewModel({
    required CharacterRepository characterRepository,
  }) : 
    _characterRepository = characterRepository;

  final CharacterRepository _characterRepository;

  Character? _character;

  Character? get character => _character;

  List<Character> _characters = [];

  List<Character> get characters => _characters;

  int amount = 0;

  void loadCharacter() async {
    try {
      _character = await _characterRepository.getCharacter(23);
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }

  void loadCharacters() async {
    try {
      _characters = await _characterRepository.getCharacters();
      for (Character character in characters) {
        print(character.name);
      }
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }


  void takeDamage () {
    if (character == null) return;
    // if tempHP can soak damage, do so
    if (character!.currentTempHp > 0) {
      // if amount of damage exceeds maxTempHP, overflow to main pool
      if ((character!.currentTempHp - amount) <= 0) {
        int difference = amount - character!.currentTempHp;

        character!.currentTempHp = character!.currentTempHp - character!.currentTempHp;
        character!.currentHp = character!.currentHp - difference;
        notifyListeners();
        return;
      }

      // take damage to tempHP
      character!.currentTempHp = character!.currentTempHp - amount;
      notifyListeners();
      return;
    }

    // take damage to main pool
    if (character!.currentHp - amount < 0) {
      character!.currentHp = 0;
      notifyListeners();
      return;
    }

    // restrict damage to 0. Can't go lower than 0
    character!.currentHp = character!.currentHp > 0 ? character!.currentHp - amount: 0;  
    notifyListeners(); 
  }

  void healDamage () {
    if (character == null) return;

    // if we can heal main pool, heal main pool
    if (character!.currentHp < character!.maxHp) {
      // if main pool overflows, set current = max and heal extra in tempHP
      if ((character!.currentHp + amount) > character!.maxHp) {
        int difference = amount - (character!.maxHp - character!.currentHp);

        character!.currentHp = character!.maxHp;

        // this should limit tempHP to maxTempHP
        if ((character!.currentTempHp + difference) > character!.maxTempHp) {
          character!.currentTempHp = character!.maxTempHp;
          notifyListeners();
          return;
        }
        
        // if we don't max out tempHP this just adds difference to tempHP
        character!.currentTempHp = character!.currentTempHp + difference;
        notifyListeners();
        return;
      }

      // heal main pool
      character!.currentHp = character!.currentHp + amount;
      notifyListeners();
      return;
    }

    // main pool maxed, should just heal tempHP
    if (character!.currentTempHp < character!.maxTempHp) {

      // max out tempHP if amount will overflow
      if (character!.currentTempHp + amount >= character!.maxTempHp) {
        character!.currentTempHp = character!.maxTempHp;
        notifyListeners();
        return;
      }

      // heal tempHP
      character!.currentTempHp = character!.currentTempHp + amount;
      notifyListeners();
      return;
    }
  }

  void increaseDamage() {
    amount++;
    notifyListeners();
  }

  void decreaseDamage() {
    amount = amount > 0 ? amount - 1 : 0;
    notifyListeners();
  }

  void useHitDie() {
    if (character == null) return;

    if (character!.currentHitDice <= 0) {
      character!.currentHitDice = 0;
      notifyListeners();
      return;
    }
    character!.currentHitDice--;
    notifyListeners();
  }

  void longRest() {
    if (character == null) return;

    if (character!.maxTempHp > 0) {
      character!.currentTempHp = character!.maxTempHp;
    }

    character!.currentHp = character!.maxHp;

    character!.currentHitDice = character!.maxHitDice;


    notifyListeners();
  }
}