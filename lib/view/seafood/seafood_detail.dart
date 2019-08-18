import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_submission_alvayonara/model/meal_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatelessWidget {
  final String idMeal;

  DetailScreen({Key key, this.idMeal}) : super(key: key);

  Future<MealModel> fetchDetail() async {
    final response = await http
        .get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMeal');

    if (response.statusCode == 200) {
      return MealModel.fromJson(json.decode(response.body)['meals'][0]);
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      color: Colors.black12,
    );

    final ingredientDessertText = Padding(
      padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
      child: Text(
        'Ingredients',
        style: TextStyle(
            fontSize: 18.0, color: Colors.black38, fontWeight: FontWeight.bold),
      ),
    );

    final body = Center(
      child: FutureBuilder<MealModel>(
        future: fetchDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: <Widget>[Hero(
                      tag: snapshot.data.strMeal,
                      child: Material(
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              radius: 72.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage('${snapshot.data.strMealThumb}'),
                            ),
                          ),
                        ),
                      )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 36.0),
                      child: Text(
                        snapshot.data.strMeal,
                        style: TextStyle(fontSize: 24.0, color: Colors.black54),
                      ),
                    ),
                    divider,
                    ingredientDessertText,
                    Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Text(
                          snapshot.data.strIngredient1 ?? '',
                          style:
                          TextStyle(fontSize: 14.0, color: Colors.black54),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Text(
                          snapshot.data.strIngredient2 ?? '',
                          style:
                          TextStyle(fontSize: 14.0, color: Colors.black54),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Text(
                          snapshot.data.strIngredient3 ?? '',
                          style:
                          TextStyle(fontSize: 14.0, color: Colors.black54),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Text(
                          snapshot.data.strIngredient4 ?? '',
                          style:
                          TextStyle(fontSize: 14.0, color: Colors.black54),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Text(
                          snapshot.data.strIngredient5 ?? '',
                          style:
                          TextStyle(fontSize: 14.0, color: Colors.black54),
                        )),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text('Seafood Details'),
          backgroundColor: Colors.cyan,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: body,
    );
  }
}