import 'package:apd/network/recipe_model.dart';
import 'package:flutter/material.dart';
import '../network/recipe_service.dart';
import 'dart:convert';
import '../network/recipe_model.dart';
import '../models/recipe_details.dart';

class RecipeSearch extends StatefulWidget {
  const RecipeSearch({super.key, required this.title});

  final String title;

  @override
  State<RecipeSearch> createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  APIRecipeQuery? recipes;
  String searchQuery = "";
  late var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadRecipes('');

    _searchController.addListener(() {
      searchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future loadRecipes(searchQuery) async {
    final response = await RecipeService.getRecipes(searchQuery, 0, 5);
    setState(() {
      recipes = APIRecipeQuery.fromJson(jsonDecode(response));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: "Search Recipes",
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (searchQuery == '') return;
                    loadRecipes(searchQuery);
                  }),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: recipes!.hits.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeDetails(
                                recipe: recipes!.hits[index].recipe)),
                      );
                    },
                    child: recipeCard(recipes!.hits[index].recipe));
              },
            ),
          ),
        ],
      ),
    );
  }

  // List<Widget> Results() {
  //   List<Widget> results = [];
  //   for (int i = 0; i < recipes!.hits.length; i++) {
  //     // results.add(new Text(recipes!.hits[i].recipe.label));
  //     results.add(recipeCard(recipes!.hits[i].recipe));
  //   }
  //   return results;
  // }

  Widget recipeCard(dynamic recipe) {
    if (recipe == null) return new Text("Search");
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image(image: NetworkImage(recipe?.image)),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              recipe?.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${recipe?.calories} KCal',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
