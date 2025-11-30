import 'package:flutter/material.dart';
import 'package:hptracker_flutter/ui/core/common/damagebutton_view.dart';
import 'package:hptracker_flutter/ui/core/common/newcharacterform_view.dart';
import 'package:hptracker_flutter/ui/home/home_viewmodel.dart';

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
          if (widget.viewModel.exception != null) return const Text("Something went wrong! Oh no!!!");
          if (character == null) return Center(child: const Text("Select a Character"));
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
                    addTempHp: widget.viewModel.addTempHp,
                    amount: widget.viewModel.amount,
                    controller: widget.viewModel.amountTextController,
                    focusNode: widget.viewModel.amountFocusNode,
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
            widget.viewModel.loadCharacters();
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
                    if (character.id != null) {
                     widget.viewModel.loadCharacter(character.id);
                    }
                  },
                )),
              ],
            );
          }) 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return NewcharacterformView(viewModel: widget.viewModel);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}