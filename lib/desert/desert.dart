import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_submission_alvayonara/data/desertData.dart';
import 'package:flutter_submission_alvayonara/model/desertModel.dart';

import 'desertDetail.dart';

class Desert extends StatelessWidget {
  final List<desertModel> desertList = getDesertData();

  List<Card> _buildGridDesert(BuildContext context) {
    var count = desertList.length;

    List<Card> card = List.generate(
        count,
        (int index) => Card(
            clipBehavior: Clip.antiAlias,
            child: Hero(
                tag: desertList[index].name,
                child: Material(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              name: desertList[index].name,
                              image: desertList[index].image,
                              ingredient: desertList[index].ingredient,
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
                                'assets/images/desert/' +
                                    desertList[index].image,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 1.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    desertList[index].name,
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
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
        children: _buildGridDesert(context),
      ),
    );
  }
}
