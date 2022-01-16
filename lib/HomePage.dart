import 'package:flutter/material.dart';
import 'package:food_time/Homepagedetail.dart';


import 'package:food_time/RecipeCard.dart';
import 'package:food_time/apiser.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _recipes;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Colors.green[400],
              ),
              SizedBox(width: 10),
              Text(
                'Food Recipe',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final item = _recipes[index];

                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Homedetail(recipes: item))),
                    child: RecipeCard(
                        title: item.name,
                        cookTime: item.totalTime,
                        rating: item.rating.toString(),
                        thumbnailUrl: item.images),
                  );
                },
              ));
  }
}
