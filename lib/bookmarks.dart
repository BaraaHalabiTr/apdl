import 'package:apd/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bookmarks'),
        ),
        body: ListView(
          children: getBookmarkWidgets(),
        ));
  }

  List<Widget> getBookmarkWidgets() {
    List<Widget> bookmarks = [];
    for (int i = 0; i < Data.bookmarks.length; i++) {
      bookmarks.add(new Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              Data.bookmarks[i].image,
              height: 100,
              width: 100,
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Data.bookmarks[i].label,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  Data.bookmarks[i].calories.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ));
    }
    return bookmarks;
  }
}
