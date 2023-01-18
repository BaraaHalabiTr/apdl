import 'package:apd/screens/groceryscreen.dart';
import 'package:flutter/material.dart';

class GroceriesTab extends StatefulWidget {
  const GroceriesTab({super.key, required this.title});
  final String title;

  @override
  State<GroceriesTab> createState() => _GroceriesTabState();
}

class _GroceriesTabState extends State<GroceriesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const GroceryScreen(),
    );
  }
}
