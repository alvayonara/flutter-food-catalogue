import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_submission_alvayonara/model/meal_model.dart';

import 'dessert_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DessertPage extends StatefulWidget {
  DessertPage({Key key}) : super(key: key);

  @override
  _DessertPageState createState() => new _DessertPageState();
}

class _DessertPageState extends State<DessertPage> {
  List<MealModel> dessertList = [];

  @override
  void initState() {
    super.initState();
    loadDessertData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    if (dessertList.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _gridViewDessert(context);
    }
  }

  Widget _gridViewDessert(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 9.0,
      children: _buildGridDessert(context),
    );
  }

  List<Card> _buildGridDessert(BuildContext context) {
    var count = dessertList.length;

    List<Card> card = List.generate(
      count,
      (int index) => Card(
        clipBehavior: Clip.antiAlias,
        child: Hero(
          tag: dessertList[index].strMeal,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      idMeal: dessertList[index].idMeal,
                    ),
                  ),
                );
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18.0 / 14.0,
                      child: Image.network(
                        '${dessertList[index].strMealThumb}',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dessertList[index].strMeal,
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return card;
  }

  loadDessertData() async {
    String dataURL =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert";

    http.Response response = await http.get(dataURL);

    var responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        dessertList = (responseJson['meals'] as List)
            .map((p) => MealModel.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load');
    }
  }
}
