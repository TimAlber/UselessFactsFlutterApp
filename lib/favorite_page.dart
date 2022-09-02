import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FactHolder {
  FactHolder({
    required this.id,
    required this.fact,

  });
  String id;
  String fact;
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var favoriteFacts = <FactHolder>[];

  @override
  void initState() {
    _getFavFacts().then((value) => {
      setState(() {
        favoriteFacts = value;
      }),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favoriteFacts.sort((a, b) => a.fact.compareTo(b.fact));
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favoriteFacts[index].fact),
          trailing: IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => {
              _deleteFav(favoriteFacts[index].id),
            },
          ),
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

  Future<void> _deleteFav(String key) async {
    var box = await Hive.openBox('factBox');
    box.delete(key);
    box.close();

    setState(() {
      favoriteFacts.removeWhere((element) => element.id == key);
    });
  }

  Future<List<FactHolder>> _getFavFacts() async {
    final ouput = <FactHolder>[];
    var box = await Hive.openBox('factBox');
    for (final key in box.keys) {
      final fact = box.get(key).toString();
      ouput.add(FactHolder(
        id: key,
        fact: fact,
      ));
    }
    box.close();
    return ouput;
  }
}
