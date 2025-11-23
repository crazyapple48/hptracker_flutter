import 'package:flutter/material.dart';

class DamageButton extends StatefulWidget {
  const DamageButton({super.key});


  @override
  State<DamageButton> createState() => _DamageButtonState();

}

class _DamageButtonState extends State<DamageButton> {
  int damage = 0;
  
  void increaseDamage() {
    setState(() {
        damage++;
    });
  }

  void decreaseDamage() {
    setState(() {
          damage = damage > 0 ? damage - 1 : 0;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(onPressed: increaseDamage, child: Text("+")),
        Text('$damage'),
        FilledButton(onPressed: decreaseDamage, child: Text("-")),
      ],
    );
  }
}