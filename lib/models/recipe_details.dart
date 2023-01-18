import 'package:apd/network/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:apd/models/recipe.dart';

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
        child: Column(children: [
          Image(
            image: NetworkImage(widget.recipe.image),
            height: 80,
            width: 80,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            widget.recipe.label,
            style: const TextStyle(fontSize: 18),
          ),
        ]),
      ),
    );
  }
}
