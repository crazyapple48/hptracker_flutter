import 'package:flutter/material.dart';

class DamageButton extends StatefulWidget {
  const DamageButton({
    super.key,
    required this.takeDamage,
    required this.heal,
    required this.increaseDamage,
    required this.decreaseDamage,
    required this.amount,
    required this.controller,
    required this.addTempHp,
  });

  final int amount;
  final VoidCallback takeDamage;
  final VoidCallback heal;
  final VoidCallback increaseDamage;
  final VoidCallback decreaseDamage;
  final VoidCallback addTempHp;
  final TextEditingController controller;

  @override
  State<DamageButton> createState() => _DamageButtonState();
}

class _DamageButtonState extends State<DamageButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            FilledButton(onPressed: widget.increaseDamage, child: Text("+")),
            SizedBox(
              width: 60,
              child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            FilledButton(onPressed: widget.decreaseDamage, child: Text("-")),
          ],
        ),
        SizedBox(width: 20),
        Column(
          children: [
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: widget.takeDamage,
              child: const Text("Damage"),
            ),
            SizedBox(height: 15),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.green),
              onPressed: widget.heal,
              child: const Text("Heal"),
            ),
            SizedBox(height: 15),
            FilledButton(
              onPressed: widget.addTempHp, 
              child: const Text("Add Temp Hp")),
          ],
        ),
      ],
    );
  }
}
