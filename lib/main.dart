import 'package:desktop_game_skincare/screens/brain.dart';
import 'package:desktop_game_skincare/screens/eye_mouth.dart';
import 'package:desktop_game_skincare/screens/home_page.dart';
import 'package:desktop_game_skincare/screens/joints.dart';
import 'package:desktop_game_skincare/screens/kidneys.dart';
import 'package:desktop_game_skincare/screens/lemph_nodes.dart';
import 'package:desktop_game_skincare/screens/lungs.dart';
import 'package:desktop_game_skincare/screens/skin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beyond Dryness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2A0068)),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
