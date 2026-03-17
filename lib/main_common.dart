import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';


class BlaBlaApp extends StatelessWidget {
  final List<InheritedProvider> providers;
  const BlaBlaApp({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(body: HomeScreen()),
    );
  }
}
