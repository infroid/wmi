import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WearMyIndiaApp());
}

class WearMyIndiaApp extends StatelessWidget {
  const WearMyIndiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virasat · Wear My India',
      debugShowCheckedModeBanner: false,
      theme: WmiTheme.light,
      home: const VirasatHomeScreen(),
    );
  }
}
