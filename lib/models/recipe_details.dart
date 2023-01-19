import 'dart:html';

import 'package:apd/network/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:apd/models/recipe.dart';
import '../data.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final APIRecipe recipe;
  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  int sliderVal = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image(
                        alignment: Alignment.topCenter,
                        width: 400,
                        height: 400,
                        image: NetworkImage(widget.recipe.image),
                        fit: BoxFit.cover),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Text(
                    widget.recipe.label,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Text(
                    '${widget.recipe.calories} KCAL',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 150, right: 150),
                  child: TextButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark),
                          Text("BookMark".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(10)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 0, 0, 0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromARGB(255, 0, 0, 0))))),
                      onPressed: () {
                        Data.bookmarks.add(widget.recipe);
                      }),
                ),
              ]),
        ),
      ),
    );
  }
}
