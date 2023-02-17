import 'package:d3tech/providers/item_provider.dart';
import 'package:d3tech/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: MaterialApp(
          title: 'Machine test',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const HomeScreen()),
    );
  }
}
