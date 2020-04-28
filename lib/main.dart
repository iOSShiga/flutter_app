


import 'package:flutter/material.dart';
import 'package:flutterapp/Product.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


//https://jsonplaceholder.typicode.com/photos

void main() {
  runApp(MyApp());
}


List<Product> parseProducts(String responseBody) {

  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromMap(json)).toList();
}

Future<List<Product>> fethedProducts() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/photos');
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  } }

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   Future<List<Product>> products;

  @override
  void initState(){
  super.initState();
  products = fethedProducts();

  }


  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      theme: ThemeData.dark(

      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated ListView'),
        ),
        body: Center(
    child: FutureBuilder<List<Product>> (
    future: products, builder: (context, snapshot) {
//       if (snapshot.hasError) print(snapshot.error);

//    if (snapshot.hasError) {
    if (snapshot.hasData){
      return new ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){
            return Card(
              child: Container(
                height: 100,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(

                    children: [

                      CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data[index].url),
                        radius: 30,
                      ),

                      SizedBox(width: 10),

                      Flexible(child: Text(snapshot.data[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,

                      )))
                    ],
                  ),
                ),
              ),
            );
          }
          );
    } else  if (snapshot.hasError){
      return Text("${snapshot.hasError}");
    }
//      return BoxProduct(products: snapshot.data)
      return new CircularProgressIndicator();
    },
    ),

    )
    )
    );
  }
}


class BoxProduct extends StatelessWidget {

  final List<Product> products;

  BoxProduct({this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index){
        return Card(
          child: Container(
            color: Colors.red,
            height: 100,
          ),
        );
        }
        );
  }
}











/*

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

  Future<Photo> futurePhoto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePhoto = futurePhoto;
    print(futurePhoto);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(

      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView Animated'),
        ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index){
            return new FutureBuilder<Photo>(
                future:futurePhoto,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return  ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index){
                          return Container(
                            child: Text(snapshot.data.title),
                          );
                        }
                        );
                  }
                  return CircularProgressIndicator();
                }
            );
          }
          ),
      ),
    );
  }
}
*/



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


//class _MyAppState extends State<MyApp> {
//
//  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
//
//  List<String> _data = [
//    WordPair.random().toString(),
//    WordPair.random().toString(),
//    WordPair.random().toString(),
//    WordPair.random().toString(),
//    WordPair.random().toString(),
//  ];
//
//
//
//
//  Widget _buildItem(BuildContext context, String item, Animation animation) {
//
//    TextStyle textStyle = new TextStyle(fontSize: 20);
//
//    return Padding(
//      padding: const EdgeInsets.all(2.0),
//      child: SizeTransition(
//        sizeFactor: animation,
//        axis: Axis.vertical,
//        child: SizedBox(
//          height: 50.0,
//          child: Card(
//            child: Center(
//              child: Text(item, style: textStyle),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//  void _addAnItem() {
//    _data.insert(0, WordPair.random().toString());
//    _listKey.currentState.insertItem(0);
//  }
//
//  void _removeLastItem() {
//    String itemToRemove = _data[0];
//
//    _listKey.currentState.removeItem(
//      0,
//          (BuildContext context, Animation animation) => _buildItem(context, itemToRemove, animation),
//      duration: const Duration(milliseconds: 250),
//    );
//
//    _data.removeAt(0);
//  }
//  void _removeAllItems() {
//    final int itemCount = _data.length;
//
//    for (var i = 0; i < itemCount; i++) {
//      String itemToRemove = _data[0];
//      _listKey.currentState.removeItem(0,
//            (BuildContext context, Animation animation) => _buildItem(context, itemToRemove, animation),
//        duration: const Duration(milliseconds: 250),
//      );
//
//      _data.removeAt(0);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text("Animated List"),
//        ),
//
//        body: AnimatedList(
//          key: _listKey,
//          initialItemCount: _data.length,
//          itemBuilder: (context, index, animation) => _buildItem(context, _data[index], animation),
//        ),
//        persistentFooterButtons: [
//
//          RaisedButton(
//            onPressed: (){
//              _addAnItem();
//            },
//            child: Text('Add an item',
//            style: TextStyle(
//              fontSize: 20,
//              color: Colors.white
//            ),
//            ),
//          ),
//
//          RaisedButton(
//            onPressed: (){
//              _removeLastItem();
//            },
//            child: Text('Remove last',
//              style: TextStyle(
//                  fontSize: 20,
//                  color: Colors.white
//              ),
//            ),
//          ),
//
//          RaisedButton(
//            onPressed: (){
//              _removeAllItems();
//
//            },
//            child: Text('Remove all',
//              style: TextStyle(
//                  fontSize: 20,
//                  color: Colors.white
//              ),
//            ),
//          ),
//        ],
//      )
//    );
//
//
//  }
//}
