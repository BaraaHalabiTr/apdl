class GroceryItem {
  final String id;
  final String name;
  final DateTime date;
  final bool isComplete;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.date,
      this.isComplete = false});

  GroceryItem copyWith(
      {String? id, String? name, DateTime? date, bool? isComplete}) {
    return GroceryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        isComplete: isComplete ?? this.isComplete);
  }
}