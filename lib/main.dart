import 'package:apd/bookmarks.dart';
import 'package:apd/grocery.dart';
import 'package:apd/models/grocery_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/recipe_search_screen.dart';

void main() => runApp(const RecipesApp());

class RecipesApp extends StatelessWidget {
  const RecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavBar());
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          NavigationDestination(
            //  selectedIcon: Icon(Icons.list),
            icon: Icon(Icons.local_grocery_store),
            label: 'Groceries',
          ),
        ],
      ),
      body: <Widget>[
        RecipeSearch(title: 'Recipes'),
        Bookmarks(),
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => GroceryManager(),
            )
          ],
          child: const GroceriesTab(title: "Groceries"),
        )
      ][currentPageIndex],
    );
  }
}
