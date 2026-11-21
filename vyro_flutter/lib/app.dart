import 'package:flutter/material.dart';
import 'core/theme/vyro_theme.dart';
import 'features/home/home_screen.dart';

class VyroStudioApp extends StatelessWidget {
  const VyroStudioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'VYRO Studio',
        debugShowCheckedModeBanner: false,
        theme: VyroTheme.dark,
        home: const HomeScreen(),
      );
}
