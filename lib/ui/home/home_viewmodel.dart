import 'package:flutter/material.dart';
import 'package:hptracker_flutter/data/repositories/character_repository.dart';
import 'package:hptracker_flutter/models/character.dart';

class HomeViewModel extends ChangeNotifier {
  final TextEditingController amountTextController = TextEditingController();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController maxHpTextController = TextEditingController();
  final TextEditingController maxTempHpTextController = TextEditingController(
    text: "0",
  );
  final TextEditingController maxHitDiceTextController =
      TextEditingController();

  final FocusNode amountFocusNode = FocusNode();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode maxHpFocusNode = FocusNode();
  final FocusNode maxTempHpFocusNode = FocusNode();
  final FocusNode maxHitDiceFocusNode = FocusNode();

  CharacterRepository characterRepository;

  Character? _character;
  Character? get character => _character;

  List<Character> _characters = [];
  List<Character> get characters => _characters;

  Exception? exception;

  int _amount = 0;
  int get amount => _amount;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _validationError;
  String? get validationError => _validationError;
  void setValidationError(String? error) {
    _validationError = error;
    notifyListeners();
  }

  HomeViewModel({required this.characterRepository}) {
    amountTextController.text = amount.toString();
    amountTextController.addListener(
      () => _onManualAmountInputChange(amountTextController),
    );
    nameTextController.addListener(
      () => _onNameInputChange(nameTextController),
    );
    maxHpTextController.addListener(
      () => _onNewNumberInputChange(maxHpTextController),
    );
    maxHitDiceTextController.addListener(
      () => _onNewNumberInputChange(maxHitDiceTextController),
    );
    maxTempHpTextController.addListener(
      () => _onNewNumberInputChange(maxTempHpTextController),
    );
    amountFocusNode.addListener(
      () => _onFocusChange(amountFocusNode, amountTextController),
    );
    nameFocusNode.addListener(
      () => _onFocusChange(nameFocusNode, nameTextController),
    );
    maxHpFocusNode.addListener(
      () => _onFocusChange(maxHpFocusNode, maxHpTextController),
    );
    maxTempHpFocusNode.addListener(
      () => _onFocusChange(maxTempHpFocusNode, maxTempHpTextController),
    );
    maxHitDiceFocusNode.addListener(
      () => _onFocusChange(maxHitDiceFocusNode, maxHitDiceTextController),
    );
  }

  @override
  void dispose() {
    amountTextController.removeListener(
      () => _onManualAmountInputChange(amountTextController),
    );
    nameTextController.removeListener(
      () => _onNameInputChange(nameTextController),
    );
    maxHpTextController.removeListener(
      () => _onNewNumberInputChange(maxHpTextController),
    );
    maxTempHpTextController.removeListener(
      () => _onNewNumberInputChange(maxTempHpTextController),
    );
    maxHitDiceTextController.removeListener(
      () => _onNewNumberInputChange(maxHitDiceTextController),
    );
    amountFocusNode.removeListener(
      () => _onFocusChange(amountFocusNode, amountTextController),
    );
    nameFocusNode.removeListener(
      () => _onFocusChange(nameFocusNode, nameTextController),
    );
    maxHpFocusNode.removeListener(
      () => _onFocusChange(maxHpFocusNode, maxHpTextController),
    );
    maxTempHpFocusNode.removeListener(
      () => _onFocusChange(maxTempHpFocusNode, maxTempHpTextController),
    );
    maxHitDiceFocusNode.removeListener(
      () => _onFocusChange(maxHitDiceFocusNode, maxHitDiceTextController),
    );
    amountTextController.dispose();
    nameTextController.dispose();
    maxHpTextController.dispose();
    maxTempHpTextController.dispose();
    maxHitDiceTextController.dispose();
    amountFocusNode.dispose();
    nameFocusNode.dispose();
    maxHpFocusNode.dispose();
    maxTempHpFocusNode.dispose();
    maxHitDiceFocusNode.dispose();
    super.dispose();
  }

  bool validateAmount() {
    final value = amountTextController.text;

    if (value.isEmpty) {
      setValidationError("Please enter a number");
      notifyListeners();
      return false;
    }
    int? newValue = int.tryParse(value);
    if (newValue == null) {
      setValidationError("Must be an integer");
      notifyListeners();
      return false;
    }

    if (newValue < 0) {
      setValidationError("Cannot be negative!");
      notifyListeners();
      return false;
    }

    if (newValue > 200) {
      setValidationError("No way it's this much");
      notifyListeners();
      return false;
    }
    setValidationError(null);
    notifyListeners();
    return true;
  }

  void _onFocusChange(FocusNode focusNode, TextEditingController controller) {
    if (focusNode.hasFocus) {
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.text.length,
      );
    }
  }

  void _onManualAmountInputChange(TextEditingController controller) {
    final int? newValue = int.tryParse(controller.text);
    if (newValue != null && newValue != _amount) {
      _amount = newValue;
      notifyListeners();
    }
  }

  void _onNameInputChange(TextEditingController controller) {
    notifyListeners();
  }

  void _onNewNumberInputChange(TextEditingController controller) {
    final int? newValue = int.tryParse(controller.text);

    if (newValue != null) {
      notifyListeners();
    }
  }

  Future<void> saveNewCharacter() async {
    _isLoading = true;
    notifyListeners();

    _character = Character(
      name: nameTextController.text,
      currentHp: int.parse(maxHpTextController.text),
      maxHp: int.parse(maxHpTextController.text),
      currentTempHp: int.parse(maxTempHpTextController.text),
      maxTempHp: int.parse(maxTempHpTextController.text),
      currentHitDice: int.parse(maxHitDiceTextController.text),
      maxHitDice: int.parse(maxHitDiceTextController.text),
    );

    await characterRepository.createCharacter(character!);

    _isLoading = false;

    nameTextController.clear();
    maxHpTextController.clear();
    maxTempHpTextController.clear();
    maxHitDiceTextController.clear();
    notifyListeners();
  }

  void loadCharacter(int? id) async {
    try {
      _character = await characterRepository.getCharacter(id!);
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
      _character = await characterRepository.updateCharacterById(
        _character!.id,
        _character!,
      );
      _amount = 0;
      amountTextController.text = _amount.toString();
      notifyListeners();
    } on Exception catch (e) {
      exception = e;
      notifyListeners();
    }
  }

  void removeCharacter(int? id) async {
    try {
      if (id != null) {
        await characterRepository.deleteCharacter(id);
        if (_character!.id == id) {
          _character = null;
        }
      }
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

  void takeDamage() async {
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
    character!.currentHp = character!.currentHp > 0
        ? character!.currentHp - amount
        : 0;
    updateCharacter();
  }

  void healDamage() {
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
    amountTextController.text = _amount.toString();
    notifyListeners();
  }

  void decreaseDamage() {
    _amount = amount > 0 ? amount - 1 : 0;
    amountTextController.text = _amount.toString();
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
