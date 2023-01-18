import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;
  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);
  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  String _name = '';
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
      _dateController.text = DateFormat('yyyy-MM-dd').format(date);
      _timeController.text = '${_timeOfDay.hour}:${_timeOfDay.minute}';
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    _dateController.addListener(() {
      _dueDate = DateTime.parse(_dateController.text);
    });

    _timeController.addListener(() {
      int splitIndex = _timeController.text.indexOf(":");
      _timeOfDay = TimeOfDay(
          hour: int.parse(_timeController.text.substring(0, splitIndex).trim()),
          minute:
              int.parse(_timeController.text.substring(splitIndex + 1).trim()));
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );
              if (widget.isUpdating) {
                widget.onUpdate(groceryItem);
              } else {
                widget.onCreate(groceryItem);
              }
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [buildNameField(), buildDateField(), BuildTimeField()],
        ),
      ),
    );
  }

  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date',
        ),
        TextField(
          controller: _dateController,
          decoration: InputDecoration(
            labelText: "Enter Date",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _dueDate ?? DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                _dateController.text = formattedDate;
              });
            }
          },
        ),
      ],
    );
  }

  Widget BuildTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time Of Day',
        ),
        TextField(
          controller: _timeController,
          decoration: InputDecoration(
            labelText: "Enter Time",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          readOnly: true,
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
                context: context, initialTime: _timeOfDay ?? TimeOfDay.now());

            if (pickedTime != null) {
              String formattedTime = '${pickedTime.hour}:${pickedTime.minute}';
              setState(() {
                _timeController.text = formattedTime;
              });
            }
          },
        ),
      ],
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
        ),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Ex: Bananas',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
