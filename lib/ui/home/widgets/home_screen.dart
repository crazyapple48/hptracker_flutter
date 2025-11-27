import 'package:flutter/material.dart';
import 'package:hptracker_flutter/ui/core/ui/damage_button/damagebutton_view.dart';
import 'package:hptracker_flutter/ui/home/home_viewmodel/home_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key, 
    required this.title,
    required this.viewModel,
    });
  final String title;
  final HomeViewModel viewModel;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    widget.viewModel.loadCharacter();
    widget.viewModel.loadCharacters();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title.toUpperCase()),),
        elevation: 2,
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          final character = widget.viewModel.character;
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
                    takeDamage: widget.viewModel.takeDamage, 
                    heal: widget.viewModel.healDamage,
                    increaseDamage: widget.viewModel.increaseDamage,
                    decreaseDamage: widget.viewModel.decreaseDamage,
                    amount: widget.viewModel.amount,
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Hit Dice: ${character.currentHitDice} / ${character.maxHitDice}"),
                  FilledButton(
                    onPressed: widget.viewModel.useHitDie, 
                    child: Text("Use a hit die")),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // FilledButton(
                  //   onPressed: () {}, 
                  //   child: Text("Short Rest"),
                  //   ),
                  FilledButton(
                    onPressed: widget.viewModel.longRest, 
                    child: Text("Long Rest")),
                ],
              )
          ],
          );
        },
      ),
      drawer: Drawer(
        child: ListenableBuilder(
          listenable: widget.viewModel, 
          builder: (BuildContext context, _) {
            final characters = widget.viewModel.characters;
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Text(
                    'Character Names',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ...characters.map((character) => ListTile(
                  title: Text(character.name),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped on ${character.name}', style: TextStyle(color: Colors.white),)),
                    );
                  },
                )),
              ],
            );
          }) 
      )
    );
  }
}