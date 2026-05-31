import 'package:flutter/material.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const ApurAquiApp());
}

class ApurAquiApp extends StatelessWidget {
  const ApurAquiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApurAqui',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }
}