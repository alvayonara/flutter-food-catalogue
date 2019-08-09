import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key key, this.name, this.image, this.ingredient})
      : super(key: key);
  final String name, image, ingredient;

  @override
  Widget build(BuildContext context) {
    final imageBreakfast = Hero(
        tag: name,
        child: Material(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 72.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/' + image),
              ),
            ),
          ),
        ));

    final nameBreakfast = Padding(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 36.0),
      child: Text(
        name,
        style: TextStyle(fontSize: 24.0, color: Colors.black54),
      ),
    );

    final divider = Divider(
      color: Colors.black12,
    );

    final ingredientBreakfastText = Padding(
      padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 2.0),
      child: Text(
        'Ingredients',
        style: TextStyle(
            fontSize: 18.0, color: Colors.black38, fontWeight: FontWeight.bold),
      ),
    );

    final ingredientBreakfast = Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          ingredient,
          style: TextStyle(fontSize: 14.0, color: Colors.black54),
        ));

    final body = SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            imageBreakfast,
            nameBreakfast,
            divider,
            ingredientBreakfastText,
            ingredientBreakfast,
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text('Breakfast Details'),
          backgroundColor: Colors.cyan,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: body,
    );
  }
}