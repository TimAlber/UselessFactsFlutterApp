import 'package:flutter/material.dart';
import 'package:useless_facts/favorite_page.dart';
import 'package:useless_facts/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
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
