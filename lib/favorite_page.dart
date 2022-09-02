import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var favoriteFacts = <String>[];

  @override
  void initState() {
    _getFavFacts().then((value) => {
      print('list: ' + value.toString()),
      setState(() {
        favoriteFacts = value;
      }),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favoriteFacts[index]),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemCount: favoriteFacts.length,
    );
  }

  Future<List<String>> _getFavFacts() async {
    final ouput = <String>[];
    var box = await Hive.openBox('factBox');
    for (final key in box.keys) {
      final fact = box.get(key).toString();
      ouput.add(fact);
    }
    box.close();
    return ouput;
  }
}
