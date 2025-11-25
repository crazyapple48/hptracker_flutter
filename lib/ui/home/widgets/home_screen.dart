import 'package:flutter/material.dart';
import 'package:hptracker_flutter/ui/core/ui/damage_button/damagebutton_view.dart';
import 'package:hptracker_flutter/ui/home/home_viewmodel/home_viewmodel.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key, 
    required this.title,
    required this.viewModel,
    });
  final String title;
  final HomeViewModel viewModel;


  @override
  Widget build(BuildContext context) {
    viewModel.loadCharacter();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title.toUpperCase()),),
        elevation: 2,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final character = viewModel.character;
          if (character == null) return const Text("Loading....");
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(character.name),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("HP: ${character.currentHp} / ${character.maxHp}"),
                      SizedBox(height: 30),
                      Text("TempHP: ${character.currentTempHp} / ${character.maxTempHp}"),
                    ],
                  ),
                  DamageButton(
                    takeDamage: viewModel.takeDamage, 
                    heal: viewModel.healDamage,
                    increaseDamage: viewModel.increaseDamage,
                    decreaseDamage: viewModel.decreaseDamage,
                    amount: viewModel.amount,
                    ),
                ],
              ),
          ],
          );
        },
      ),
      drawer: Column(
        children: [Placeholder()],
      ),
    );
  }
}