import 'dart:io';

import 'package:app_store/pages/discover.dart';
import 'package:app_store/sys/firebase_options.dart';
import 'package:app_store/sys/navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

runCommand() async {
  await Process.run('winget',
      ['upgrade', 'Python.Python.3.12']); // List files in current directory
  // Output the command's output
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Store',
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyan,
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
            appBarTitle: "Home - Scopri app e servizi",
            text: "Home",
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
          destination: Pag2(),
        ),
      ],
    );
  }
}

class Pag1 extends StatelessWidget {
  const Pag1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const ListTile(
        title: Divider(),
        subtitle: Text("Tutti i diritti riservati © 2024 Riccardo Debellini"),
      ),
    );
  }
}

class Pag2 extends StatelessWidget {
  const Pag2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const ListTile(
        title: Divider(),
        subtitle: Text("Tutti i diritti riservati © 2024 Riccardo Debellini"),
      ),
    );
  }
}