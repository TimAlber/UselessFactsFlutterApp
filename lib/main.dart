import 'package:flutter/material.dart';
import 'package:useless_facts/favorite_page.dart';
import 'package:useless_facts/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.favorite)),
              ],
            ),
            title: const Text('Useless Facts'),
          ),
          body: const TabBarView(
            children: [
              MyHomePage(),
              FavoritePage(),
            ],
          ),
        ),
      ),
    );
  }
}
