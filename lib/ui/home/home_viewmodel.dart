import 'package:flutter/material.dart';
import 'package:hptracker_flutter/data/repositories/character_repository.dart';
import 'package:hptracker_flutter/models/character.dart';

class HomeViewModel extends ChangeNotifier{
  final TextEditingController textController = TextEditingController();

  CharacterRepository characterRepository;

  Character? _character;

  Character? get character => _character;

  List<Character> _characters = [];

  List<Character> get characters => _characters;

  Exception? exception;

  int _amount = 0;

  int get amount => _amount;

  HomeViewModel({
    required  this.characterRepository,
  })   {
    textController.text = amount.toString();
    textController.addListener(_onManualInputChange);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _onManualInputChange() {
    final int? newValue = int.tryParse(textController.text);
    if (newValue != null && newValue != _amount) {
      _amount = newValue;
      notifyListeners();
    }
  }

  void loadCharacter(int id) async {
    try {
      _character = await characterRepository.getCharacter(id);
      notifyListeners();
    } on Exception catch (e) {
      exception = e;
      notifyListeners();
    }
  }

  void loadCharacters() async {
    try {
      _characters = await characterRepository.getCharacters();
      notifyListeners();
    } on Exception catch (e) {
      exception = e;
      notifyListeners();
    }
  }

  void updateCharacter() async {
    try {
      if (_character == null) return;
      _character = await characterRepository.updateCharacterById(_character!.id, _character!);
      _amount = 0;
      textController.text = _amount.toString();
      notifyListeners();
    } on Exception catch (e) {
      exception = e;
      notifyListeners();
    }
  }

  void addTempHp() {
    if (character == null) return;
    character!.maxTempHp = amount;
    character!.currentTempHp = character!.maxTempHp;
    updateCharacter();
  } 

  void takeDamage () {
    if (character == null) return;
    // if tempHP can soak damage, do so
    if (character!.currentTempHp > 0) {
      // if amount of damage exceeds maxTempHP, overflow to main pool
      if ((character!.currentTempHp - amount) <= 0) {
        int difference = amount - character!.currentTempHp;

        character!.currentTempHp = 0;

        if ((character!.currentHp - difference) < 0) {
          character!.currentHp = 0;
          updateCharacter();
          return;
        }
        character!.currentHp = character!.currentHp - difference;
        updateCharacter();
        return;
      }

      // take damage to tempHP
      character!.currentTempHp = character!.currentTempHp - amount;
      updateCharacter();
      return;
    }

    // take damage to main pool
    if (character!.currentHp - amount < 0) {
      character!.currentHp = 0;
      updateCharacter();
      return;
    }

    // restrict damage to 0. Can't go lower than 0
    character!.currentHp = character!.currentHp > 0 ? character!.currentHp - amount: 0; 
    updateCharacter();
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
          updateCharacter();
          return;
        }
        
        // if we don't max out tempHP this just adds difference to tempHP
        character!.currentTempHp = character!.currentTempHp + difference;
        updateCharacter();
        return;
      }

      // heal main pool
      character!.currentHp = character!.currentHp + amount;
      updateCharacter();
      return;
    }

    // main pool maxed, should just heal tempHP
    if (character!.currentTempHp < character!.maxTempHp) {

      // max out tempHP if amount will overflow
      if (character!.currentTempHp + amount >= character!.maxTempHp) {
        character!.currentTempHp = character!.maxTempHp;
        updateCharacter();
        return;
      }

      // heal tempHP
      character!.currentTempHp = character!.currentTempHp + amount;
      updateCharacter();
      return;
    }
  }

  void increaseDamage() {
    _amount++;
    textController.text = _amount.toString();
    notifyListeners();
  }

  void decreaseDamage() {
    _amount = amount > 0 ? amount - 1 : 0;
    textController.text = _amount.toString();
    notifyListeners();
  }

  void useHitDie() {
    if (character == null) return;

    if (character!.currentHitDice <= 0) {
      character!.currentHitDice = 0;
      updateCharacter();
      return;
    }
    character!.currentHitDice--;
    updateCharacter();
  }

  void longRest() {
    if (character == null) return;

    if (character!.maxTempHp > 0) {
      character!.currentTempHp = character!.maxTempHp;
    }

    character!.currentHp = character!.maxHp;

    character!.currentHitDice = character!.maxHitDice;

    updateCharacter();
  }
}