import 'package:http/http.dart';

const String apiKey = '968451ca160a7eb89409988371961876';
const String apiId = '3c5f2fc4';
const String apiUrl = 'https://api.edamam.com/search';

class RecipeService {
  static Future getData(String url) async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  static Future<dynamic> getRecipes(String query, int from, int to) async {
    final recipeData = await getData(
        '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to');
    return recipeData;
  }
}
