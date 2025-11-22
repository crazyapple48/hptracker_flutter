import 'package:flutter/material.dart';

import 'ui/home/widgets/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hp Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 124, 7, 170)),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 124, 7, 170), brightness: Brightness.dark)
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(
        title: 'Hp Tracker',
        characterName: "Charles",
        currentHp: 25,
        maxHp: 25,
        currentTempHp: 0,
        maxTempHp: 0,
        currentHitDice: 10,
        maxHitDice: 10,),
    );
  }
}

