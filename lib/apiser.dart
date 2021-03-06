import 'dart:convert';

import 'package:food_time/Recipe.dart';
import 'package:http/http.dart' as http;

import 'secrets.dart';

class RecipeApi {
  static Future getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": '$mySecretKey',
      "x-rapidapi-host": 'yummly2.p.rapidapi.com',
      "useQueryString": "true"
    });
    Map data = jsonDecode(response.body);
    List l1 = [];

    for (var i in data['feed']) {
      l1.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(l1);
  }
}
