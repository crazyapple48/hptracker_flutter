import 'package:flutter/material.dart';
import 'package:hptracker_flutter/data/services/hptracker_api_service.dart';
import 'package:hptracker_flutter/ui/home/home_viewmodel/home_viewmodel.dart';

import 'data/repositories/character_repository.dart';
import 'ui/home/widgets/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CharacterRepository characterRepository = CharacterRepository(apiService: HptrackerApiService());

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
      home: MyHomePage(
        title: 'Hp Tracker',
        viewModel: HomeViewModel(characterRepository: characterRepository)
        ),
    );
  }
}

