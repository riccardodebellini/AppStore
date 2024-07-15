import 'dart:io';

import 'package:app_store/discover.dart';
import 'package:app_store/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_store/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

}

runCommand() async {
  print("Start");
  final result = await Process.run('winget',
      ['upgrade', 'Python.Python.3.12']); // List files in current directory
  print(result.stdout); // Output the command's output
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Store',
      theme: ThemeData(
        fontFamily: GoogleFonts.titilliumWeb().fontFamily,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: MediaQuery.platformBrightnessOf(context)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigation(
      pageData: [
        MainNavigationDest(
            appBarTitle: "Scopri app e servizi",
            text: "Scopri",
            icon: Icon(Icons.interests_rounded),
            destination: DiscoverPage()),
        MainNavigationDest(
            appBarTitle: "Gestisci le app installate",
            text: "Dispositivo",
            icon: Icon(Icons.devices_rounded),
            destination: Pag1()),
        MainNavigationDest(
            appBarTitle: "Sviluppo",
            text: "Dev",
            icon: Icon(Icons.developer_mode_rounded),
            destination: Pag1(),
        ),
      ],
    );
  }
}

class Pag1 extends StatelessWidget {
  const Pag1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("1"),
    );
  }
}

class Pag2 extends StatelessWidget {
  const Pag2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("2"),
    );
  }
}

class Pag3 extends StatelessWidget {
  const Pag3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("3"),
    );
  }
}
