import 'package:flutter/foundation.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final groceries = <GroceryItem>[];
  List<GroceryItem> get groceryItems => List.unmodifiable(groceries);

  void addItem(GroceryItem item) {
    groceries.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    groceries.removeAt(index);
    notifyListeners();
  }

  void editItem(GroceryItem item, int index) {
    groceries[index] = item;
    notifyListeners();
  }

  void setItemState(int index, bool state) {
    final item = groceries[index];
    groceries[index] = item.copyWith(isComplete: state);
    notifyListeners();
  }
}
