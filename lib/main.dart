import 'package:flutter/material.dart';

import 'package:flutter_submission_alvayonara/food_data.dart';
import 'package:flutter_submission_alvayonara/model/food.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Home(),
    );
  }
}

class Home extends StatelessWidget {
  List<food> foods = getFoodData();

  List<Card> _buildGridFood(BuildContext context) {
    var count = foods.length;

    List<Card> card = List.generate(
        count,
        (int index) => Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            nama: foods[index].nama,
                            gambar: foods[index].gambar,
                            bahanbaku: foods[index].bahanbaku,
                          ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18.0 / 14.0,
                      child: Image.asset(
                        'assets/images/' + foods[index].gambar,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            foods[index].nama,
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
    return card;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Chinese Food'),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridFood(context),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({Key key, this.nama, this.gambar, this.bahanbaku})
      : super(key: key);
  final String nama, gambar, bahanbaku;

  @override
  Widget build(BuildContext context) {
    final imageFood = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/' + gambar),
        ),
      ),
    );

    final nameFood = Padding(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 36.0),
      child: Text(
        nama,
        style: TextStyle(fontSize: 24.0, color: Colors.black54),
      ),
    );

    final divider = new Divider(
      color: Colors.black12,
    );

    final bahanFoodText = Padding(
      padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 2.0),
      child: Text(
        'Informasi Bahan',
        style: TextStyle(
            fontSize: 18.0, color: Colors.black38, fontWeight: FontWeight.bold),
      ),
    );

    final bahanFood = Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          bahanbaku,
          style: TextStyle(fontSize: 14.0, color: Colors.black54),
        ));

    final body = SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28.0),
        child: Column(
          children: <Widget>[
            imageFood,
            nameFood,
            divider,
            bahanFoodText,
            bahanFood
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text('Food Details'),
          backgroundColor: Colors.cyan,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: body,
    );
  }
}
