import 'package:flutter/material.dart';
import 'package:hptracker_flutter/ui/core/ui/damage_button/damagebutton_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key, 
    required this.title,
    required this.characterName,
    required this.currentHp,
    required this.maxHp,
    required this.maxTempHp,
    required this.currentTempHp,
    required this.currentHitDice,
    required this.maxHitDice});
  final String title;

  final String characterName;
  final int currentHp;
  final int maxHp;
  final int currentTempHp;
  final int maxTempHp;
  final int currentHitDice;
  final int maxHitDice;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
              Text(widget.characterName),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("HP: ${widget.currentHp} / ${widget.maxHp}"),
                    SizedBox(height: 30),
                    Text("TempHP: ${widget.currentTempHp} / ${widget.maxTempHp}"),
                  ],
                ),
                DamageButton(),
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