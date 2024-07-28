import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthSystem extends StatelessWidget {
  final Widget ifNotLogged;
  final Widget ifLogged;

  const AuthSystem(
      {super.key, required this.ifNotLogged, required this.ifLogged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ifLogged;
              } else {
                return ifNotLogged;
              }
            }),
      ),
    );
  }
}
