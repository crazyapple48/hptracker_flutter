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

  Exception? exception;

  int amount = 0;

  void loadCharacter(int id) async {
    try {
      _character = await _characterRepository.getCharacter(id);
      notifyListeners();
    } on Exception catch (e) {
      exception = e;
      notifyListeners();
    }
  }

  void loadCharacters() async {
    try {
      _characters = await _characterRepository.getCharacters();
      notifyListeners();
    } on Exception catch (e) {
      exception = e;
      notifyListeners();
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
        amount = 0;
        notifyListeners();
        return;
      }

      // take damage to tempHP
      character!.currentTempHp = character!.currentTempHp - amount;
      amount = 0;
      notifyListeners();
      return;
    }

    // take damage to main pool
    if (character!.currentHp - amount < 0) {
      character!.currentHp = 0;
      amount = 0;
      notifyListeners();
      return;
    }

    // restrict damage to 0. Can't go lower than 0
    character!.currentHp = character!.currentHp > 0 ? character!.currentHp - amount: 0;  
    amount = 0;
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
          amount = 0;
          notifyListeners();
          return;
        }
        
        // if we don't max out tempHP this just adds difference to tempHP
        character!.currentTempHp = character!.currentTempHp + difference;
        amount = 0;
        notifyListeners();
        return;
      }

      // heal main pool
      character!.currentHp = character!.currentHp + amount;
      amount = 0;
      notifyListeners();
      return;
    }

    // main pool maxed, should just heal tempHP
    if (character!.currentTempHp < character!.maxTempHp) {

      // max out tempHP if amount will overflow
      if (character!.currentTempHp + amount >= character!.maxTempHp) {
        character!.currentTempHp = character!.maxTempHp;
        amount = 0;
        notifyListeners();
        return;
      }

      // heal tempHP
      character!.currentTempHp = character!.currentTempHp + amount;
      amount = 0;
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