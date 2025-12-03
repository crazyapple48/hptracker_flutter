import 'package:flutter/material.dart';
import 'package:hptracker_flutter/ui/home/home_viewmodel.dart';

class DamageButton extends StatefulWidget {
  const DamageButton({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<DamageButton> createState() => _DamageButtonState();
}

class _DamageButtonState extends State<DamageButton> {
  final _damageKey = GlobalKey<FormState>();

  void _submitDamage() {
    final viewModel = widget.viewModel;

    final isValid = _damageKey.currentState!.validate();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (!isValid) {
      final errorMessage =
          viewModel.validationError ?? "An unknown error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      viewModel.takeDamage();
    }
  }

  void _submitHeal() {
    final viewModel = widget.viewModel;

    final isValid = _damageKey.currentState!.validate();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (!isValid) {
      final errorMessage =
          viewModel.validationError ?? "An unknown error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      viewModel.healDamage();
    }
  }

  void _submitTempHp() {
    final viewModel = widget.viewModel;

    final isValid = _damageKey.currentState!.validate();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (!isValid) {
      final errorMessage =
          viewModel.validationError ?? "An unknown error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      viewModel.addTempHp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _damageKey,
      child: Row(
        children: [
          Column(
            children: [
              FilledButton(
                onPressed: widget.viewModel.increaseDamage,
                child: Text("+"),
              ),
              Divider(),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: widget.viewModel.amountTextController,
                  focusNode: widget.viewModel.amountFocusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(height: 0),
                    helperStyle: TextStyle(height: 0),
                    helperText: " ",
                    errorText: " ",
                  ),
                  validator: (value) {
                    final result = widget.viewModel.validateAmount();
                    if (!result) {
                      return "";
                    }
                    return null;
                  },
                ),
              ),
              FilledButton(
                onPressed: widget.viewModel.decreaseDamage,
                child: Text("-"),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: _submitDamage,
                child: const Text("Damage"),
              ),
              SizedBox(height: 15),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                onPressed: _submitHeal,
                child: const Text("Heal"),
              ),
              SizedBox(height: 15),
              FilledButton(
                onPressed: _submitTempHp,
                child: const Text("Add Temp Hp"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
