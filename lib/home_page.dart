import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:useless_facts/fact.dart';
import 'package:hive/hive.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var currentFact = '';
  var currentID = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(currentFact),
          IconButton(
            onPressed: () => {
              _favFact(),
            },
            icon: const Icon(Icons.favorite),
          ),
          TextButton(
            onPressed: () => {
              _getFact(),
            },
            child: const Text('Get New Fact'),
          )
        ],
      ),
    );
  }


  void _favFact() async {
    if(currentID == '' || currentFact == ''){
      return;
    }
    var box = await Hive.openBox('factBox');
    if(!box.containsKey(currentID)){
      box.put(currentID, currentFact);
    }
    box.close();
  }

  void _getFact() async {
    var request =
        Request('GET', Uri.parse('https://uselessfacts.jsph.pl/random.json'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final output = await response.stream.bytesToString();
      final uselessFact = uselessFactFromJson(output);

      setState(() {
        currentFact = uselessFact.text;
        currentID = uselessFact.id;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}
