import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWordsPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>(); // Write about SET

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if(item.isOdd)
          return Divider();

        final index = item ~/ 2; // The ~/ operator divides and returns the floored (integer part) of the result.


        if(index >= _randomWordsPairs.length) {
          _randomWordsPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordsPairs[index]);

      },
    ); // ListView.builder
  }


  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile (
      title: Text(pair.asPascalCase,
        style: TextStyle(
        fontSize: 18.0
        ), // TextStyle
      ), //Text
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null ,
      ), // Icon
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _savedWordPairs.remove(pair);
          }
          else {
            _savedWordPairs.add(pair);
          }
        });
      },
    ); // ListTile
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context){
          final Iterable <ListTile> tiles = _savedWordPairs.map((WordPair pair){
            return ListTile(
              title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0),),
            ); // ListTile
          });

          final List<Widget> divided = ListTile.divideTiles(
              tiles: tiles,
              context: context
          ).toList();

          return Scaffold(
            appBar: AppBar(title: Text("Saved WordPairs"),),
            body: ListView(children: divided),
          ); // Scaffold
    })); // MaterialPageRoute
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WordPair Generator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ) // IconButton
        ], // <Widget>[]
      ), // AppBar
      body: _buildList()
    ); // Scaffold
  }
}
