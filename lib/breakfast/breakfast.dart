import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_submission_alvayonara/data/breakfast_data.dart';
import 'package:flutter_submission_alvayonara/model/breakfast_model.dart';

import 'breakfast_detail.dart';

class Breakfast extends StatelessWidget {
  final List<breakfastModel> breakfastList = getBreakfastData();

  List<Card> _buildGridBreakfast(BuildContext context) {
    var count = breakfastList.length;

    List<Card> card = List.generate(
        count,
            (int index) =>
            Card(
                clipBehavior: Clip.antiAlias,
                child: Hero(
                    tag: breakfastList[index].name,
                    child: Material(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(
                                      name: breakfastList[index].name,
                                      image: breakfastList[index].image,
                                      ingredient: breakfastList[index]
                                          .ingredient,
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
                                    child: Image.asset(
                                      'assets/images/breakfast/' +
                                          breakfastList[index].image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 12.0, 16.0, 1.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        Text(
                                          breakfastList[index].name,
                                        ),
                                        SizedBox(height: 8.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          )
                      ),
                    ))));
    return card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridBreakfast(context),
      ),
    );
  }
}
