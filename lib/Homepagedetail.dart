import 'package:flutter/material.dart';


class Homedetail extends StatelessWidget {
  final recipes;
  

  const Homedetail({this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(color: Colors.black)),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(recipes.images),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(recipes.name,
                    style: TextStyle(fontSize: 19, color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [Text('Ingredients :')],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
