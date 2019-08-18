import 'package:flutter/material.dart';
import 'package:flutter_submission_alvayonara/view/dessert/dessert.dart';
import 'package:flutter_submission_alvayonara/view/seafood/seafood.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _indexSelected = 0;
  final _widgetOptions = [
    DessertPage(),
    SeafoodPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Catalogue'),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_indexSelected),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.cake), title: Text('Dessert')),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text('Seafood')),
        ],
        currentIndex: _indexSelected,
        fixedColor: Colors.cyan,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _indexSelected = index;
    });
  }
}
