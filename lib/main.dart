import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


//class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
//  List<int> _list = [];
//  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//
//
//  void _addItem() {
//    final int _index = _list.length;
//    _list.insert(_index,_index);
//    _listKey.currentState.insertItem(_index);
//  }
//
//  void _removeItem() {
//    final int _index = _list.length-1;
//    _listKey.currentState.removeItem(_index,(context,animation)=> Container()); /// what I'm supposed to do here
//    _list.removeAt(_index);
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('List View'),
//        ),
//        body: Center(
//
//          child: AnimatedList(
//            key: _listKey,
//            initialItemCount: 0,
//            itemBuilder: (BuildContext context, int index, Animation animation) {
//              return _buildItem(_list[index].toString(),animation);
//            },),
//        ),
//        floatingActionButton: Row(
//          mainAxisAlignment: MainAxisAlignment.end,
//          crossAxisAlignment: CrossAxisAlignment.end,
//          children: <Widget>[
//            Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
//                FloatingActionButton(
//                  onPressed:()=> _addItem(),
//                  tooltip: 'Increment',
//                  child: Icon(Icons.add),),
//                FloatingActionButton(
//                  onPressed: ()=>_removeItem(),
//                  tooltip: 'Decrement',
//                  child: Icon(Icons.remove),),
//              ],),
//          ],),
//      ),
//    );
//  }
//
//  Widget _buildItem(String _item, Animation _animation) {
//    return SizeTransition(
//      sizeFactor: _animation,
//      child: Card(
//        child: ListTile(
//          title: Text(
//            _item,
//          ),
//        ),
//      ),
//    );
//  }
//}


class _MyAppState extends State<MyApp> {

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> _data = [
    WordPair.random().toString(),
    WordPair.random().toString(),
    WordPair.random().toString(),
    WordPair.random().toString(),
    WordPair.random().toString(),
  ];




  Widget _buildItem(BuildContext context, String item, Animation animation) {

    TextStyle textStyle = new TextStyle(fontSize: 20);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        child: SizedBox(
          height: 50.0,
          child: Card(
            child: Center(
              child: Text(item, style: textStyle),
            ),
          ),
        ),
      ),
    );
  }
  void _addAnItem() {
    _data.insert(0, WordPair.random().toString());
    _listKey.currentState.insertItem(0);
  }

  void _removeLastItem() {
    String itemToRemove = _data[0];

    _listKey.currentState.removeItem(
      0,
          (BuildContext context, Animation animation) => _buildItem(context, itemToRemove, animation),
      duration: const Duration(milliseconds: 250),
    );

    _data.removeAt(0);
  }
  void _removeAllItems() {
    final int itemCount = _data.length;

    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _data[0];
      _listKey.currentState.removeItem(0,
            (BuildContext context, Animation animation) => _buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 250),
      );

      _data.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Animated List"),
        ),

        body: AnimatedList(
          key: _listKey,
          initialItemCount: _data.length,
          itemBuilder: (context, index, animation) => _buildItem(context, _data[index], animation),
        ),
        persistentFooterButtons: [

          RaisedButton(
            onPressed: (){
              _addAnItem();
            },
            child: Text('Add an item',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
            ),
          ),

          RaisedButton(
            onPressed: (){
              _removeLastItem();
            },
            child: Text('Remove last',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ),

          RaisedButton(
            onPressed: (){
              _removeAllItems();

            },
            child: Text('Remove all',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ),
        ],
      )
    );


  }
}
