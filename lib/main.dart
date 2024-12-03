import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:game/screen/game.dart';

void main() {
  runApp(DevicePreview(
    builder: (context) => const MainApp(), // Wrap your app
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
