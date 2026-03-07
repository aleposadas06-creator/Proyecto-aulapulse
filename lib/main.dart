import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

void main() {
  runApp(const AulaPulseApp());
}

class AulaPulseApp extends StatelessWidget {
  const AulaPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AulaPulse',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}