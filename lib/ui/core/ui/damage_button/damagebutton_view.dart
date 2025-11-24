import 'package:flutter/material.dart';

class DamageButton extends StatefulWidget {
  const DamageButton({
    super.key,
    required this.takeDamage,
    required this.heal,
    required this.increaseDamage,
    required this.decreaseDamage,
    required this.amount
    });

  final int amount;
  final VoidCallback takeDamage;
  final VoidCallback heal;
  final VoidCallback increaseDamage;
  final VoidCallback decreaseDamage;

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
            Text('${widget.amount}'),
            FilledButton(onPressed: widget.decreaseDamage, child: Text("-")),
          ],
        ),
        Column(
          children: [
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: widget.takeDamage, 
              child: const Text("Damage")),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.green),
              onPressed: widget.heal, 
              child: const Text("Heal"))
          ],
        ),
      ],
    );
  }
}