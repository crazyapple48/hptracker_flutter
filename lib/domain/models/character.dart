
class Character {

  int id;
  String name;
  int currentHp;
  int maxHp;
  int currentTempHp;
  int maxTempHp;
  int currentHitDice;
  int maxHitDice;

  Character({
    required this.id,
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
      {'id': int id, 'name': String name, 'currentHp': int currentHp, 'maxHp': int maxHp, 'tempHp': int currentTempHp, 'maxTempHp': int maxTempHp, 'hitDiceTotal': int maxHitDice, 'hitDiceUsed': int currentHitDice} => Character(
        id: id,
        name: name,
        currentHp: currentHp,
        maxHp: maxHp,
        currentTempHp: currentTempHp,
        maxTempHp: maxTempHp,
        maxHitDice: maxHitDice,
        currentHitDice: currentHitDice
      ),
      _ => throw const FormatException('Failed to load Character.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "currentHp": currentHp,
      "maxHp": maxHp,
      "tempHp": currentTempHp,
      "maxTempHp": maxTempHp,
      "hitDiceUsed": currentHitDice,
      "hitDiceTotal": maxHitDice
    };
  }
}