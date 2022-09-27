import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:useless_facts/fact.dart';
import 'package:hive/hive.dart';
import 'package:useless_facts/favorite_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isFaved = false;
  FactHolder? currentFact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Text(
              currentFact != null ? currentFact!.fact : '',
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () => {
              _favFact(),
            },
            icon: Icon(
              Icons.favorite,
              color: isFaved ? Colors.red : Colors.black,
            ),
            iconSize: 100,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            onPressed: () => {
              _getFact(),
            },
            child: const Text('Get New Fact',
                style: TextStyle(fontSize: 25, color: Colors.blue)),
          )
        ],
      ),
    );
  }

  void _favFact() async {
    if (currentFact == null) {
      return;
    }

    setState(() {
      isFaved = !isFaved;
    });

    var box = await Hive.openBox('factBox');
    if (!box.containsKey(currentFact!.id) && isFaved) {
      box.put(currentFact!.id, currentFact!.fact);
    }

    if (box.containsKey(currentFact!.id) && !isFaved) {
      box.delete(currentFact!.id);
    }

    box.close();
  }

  void _getFact() async {
    var request =
        Request('GET', Uri.parse('https://uselessfacts.jsph.pl/random.json?language=de'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final output = await response.stream.bytesToString();
      final uselessFact = uselessFactFromJson(output);

      setState(() {
        currentFact = FactHolder(id: uselessFact.id, fact: uselessFact.text);
        isFaved = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}
