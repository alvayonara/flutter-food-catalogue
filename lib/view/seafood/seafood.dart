import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_submission_alvayonara/model/meal_model.dart';

import 'seafood_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeafoodPage extends StatefulWidget {
  SeafoodPage({Key key}) : super(key: key);

  @override
  _SeafoodPageState createState() => new _SeafoodPageState();
}

class _SeafoodPageState extends State<SeafoodPage> {
  List<MealModel> seafoodList = [];

  @override
  void initState() {
    super.initState();
    loadSeafoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    if (seafoodList.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _gridViewSeafood(context);
    }
  }

  Widget _gridViewSeafood(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 9.0,
      children: _buildGridSeafood(context),
    );
  }

  List<Card> _buildGridSeafood(BuildContext context) {
    var count = seafoodList.length;

    List<Card> card = List.generate(
      count,
      (int index) => Card(
        clipBehavior: Clip.antiAlias,
        child: Hero(
          tag: seafoodList[index].strMeal,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      idMeal: seafoodList[index].idMeal,
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
                        '${seafoodList[index].strMealThumb}',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            seafoodList[index].strMeal,
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

  loadSeafoodData() async {
    String dataURL =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";

    http.Response response = await http.get(dataURL);

    var responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        seafoodList = (responseJson['meals'] as List)
            .map((p) => MealModel.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load');
    }
  }
}
