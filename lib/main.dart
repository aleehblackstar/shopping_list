import 'package:flutter/material.dart';
import 'package:shopping_list/pages/home_page.dart';

void main() {
  runApp(const ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: SafeArea(
        child: const HomePage()), // Vamos substituir pela nossa HomePage logo mais
    );
  }
}
