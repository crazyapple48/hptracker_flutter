import 'package:flutter/material.dart';
import 'package:hptracker_flutter/ui/core/ui/damage_button/damagebutton_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key, 
    required this.title,
    });
  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int amount = 0;

  String characterName = "Max";
  int currentHp = 25;
  int maxHp = 25;
  int currentTempHp = 0;
  int maxTempHp = 0;
  int currentHitDice = 10;
  int maxHitDice = 10;

  void takeDamage () {

    setState(() {
      if (currentTempHp > 0) {
        if ((currentTempHp - amount) <= 0) {
          int difference = amount - currentTempHp;

          currentTempHp = 0;
          currentHp = currentHp - difference;
          return;
        }
        currentTempHp = currentTempHp - amount;
        return;
      }
      currentHp = currentHp > 0 ? currentHp - amount: 0;  
    });   
  }

  void healDamage () {
    setState(() {
      if (currentHp < maxHp) {
        if ((currentHp + amount) > maxHp) {
          int difference = amount - (maxHp - currentHp);

          currentHp = maxHp;

          if ((currentTempHp + difference) > maxTempHp) {
            currentTempHp = maxTempHp;
            return;
          }
          currentTempHp = currentTempHp + difference;
          return;
        }
        currentHp = currentHp + amount;
        return;
      }
      if (currentTempHp < maxTempHp) {
        currentTempHp = currentTempHp + amount;
        return;
      }
    });

  }

  void increaseDamage() {
    setState(() {
        amount++;
    });
  }

  void decreaseDamage() {
    setState(() {
          amount = amount > 0 ? amount - 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title.toUpperCase()),),
        elevation: 2,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(characterName),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("HP: $currentHp / $maxHp"),
                    SizedBox(height: 30),
                    Text("TempHP: $currentTempHp / $maxTempHp"),
                  ],
                ),
                DamageButton(
                  takeDamage: takeDamage, 
                  heal: healDamage,
                  increaseDamage: increaseDamage,
                  decreaseDamage: decreaseDamage,
                  amount: amount,
                  ),
              ],
            ),
        ],
        ),
      drawer: Column(
        children: [Placeholder()],
      ),
    );
  }
}