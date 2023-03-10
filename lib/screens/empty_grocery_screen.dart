import 'package:flutter/material.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No Groceries',
              style: TextStyle(fontSize: 21.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Shopping for ingredients?\nTap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
