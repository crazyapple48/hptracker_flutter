
class Character {

  String name;
  int currentHp;
  int maxHp;
  int currentTempHp;
  int maxTempHp;
  int currentHitDice;
  int maxHitDice;

  Character({
    required this.name,
    required  this.currentHp,
    required  this.maxHp,
    required  this.currentTempHp,
    required  this.maxTempHp,
    required  this.currentHitDice,
    required  this.maxHitDice,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'currentHp': int currentHp, 'maxHp': int maxHp, 'tempHp': int currentTempHp, 'hitDiceTotal': int maxHitDice, 'hitDiceUsed': int currentHitDice} => Character(
        name: name,
        currentHp: currentHp,
        maxHp: maxHp,
        currentTempHp: currentTempHp,
        maxTempHp: currentTempHp,
        maxHitDice: maxHitDice,
        currentHitDice: currentHitDice
      ),
      _ => throw const FormatException('Failed to load Character.'),
    };
  }
}