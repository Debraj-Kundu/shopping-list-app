import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.blueAccent, primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final _items = List();
  final _done = Set();
  final TextEditingController addeditem = TextEditingController(text: '');

  void _addItemToList(){
    setState(() {
      int index = _items.length;
      _items.add(addeditem.text);
      addeditem.text = '';
    });
  }
  Widget _buildRow(String itemtext){
    final alreadysaved = _done.contains(itemtext);
    return Column(
      children: [
        ListTile(
          title: Text(itemtext),
          trailing: Icon(
            alreadysaved?Icons.check_circle:Icons.check_circle_outline,
            color: alreadysaved?Colors.green:null,
          ),
          onTap: (){
            setState(() {
              if(alreadysaved){
                _done.remove(itemtext);
              }else{
                _done.add(itemtext);
              }
            });
          },
        ),
        Divider(),
      ],
    );
  }
  Widget _shoppingListItems(){
    return ListView.builder(
      itemBuilder: (BuildContext context, int i){
        if(i < _items.length){
          return _buildRow(_items[i]);
        }
      },
    );
  }
  void _pushSaved(){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context){
            final tiles = _done.map(
              (itemtext){
                return ListTile(
                  title: Text(
                    itemtext,
                  ),
                );
              }
            );
            final divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();
            return Scaffold(
              appBar: AppBar(
                title: Text('Done'),
              ),
              body: ListView(children: divided),
            );
          }
        )
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sunday Shopping',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: _pushSaved,
            splashColor: Colors.pinkAccent,
          )
        ],
      ),
      body: _shoppingListItems(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _alertToAddItems,
      ),
    );
  }
  void _alertToAddItems(){
    var addItem = AlertDialog(
      title: Text('Add Items'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Text('Add item you want to add!'),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add Item',
            ),
            controller: addeditem,
          ),
          TextButton(
            child: Text('Done'),
            onPressed: (){
              _addItemToList();
              Navigator.of(context).pop();
            }
          )
        ],
        
      ),
      
    );
    showDialog(
      context: context,
      builder: (BuildContext context){
        return addItem;
      }
    );
  }
}
