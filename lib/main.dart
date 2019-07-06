import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_1/utils/database_helper.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name='Name',class1='class';

Widget getdata(){
  return StreamBuilder(
        stream: Firestore.instance.collection('Attraction Points').document('CXNJp4yQyJwEHjORxLAp').snapshots(),
        builder:(context , snapshot){
          print('in button');
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
          }
          else if(!snapshot.hasData) print('loading data.... !!');
          else{
              print(snapshot.data.document['Name']);

          } 
        },
      );
}
 final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('city').document('naran').collection('Attraction Points').snapshots(),
        builder:(context , snapshot){
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          else if(!snapshot.hasData) return Text('loading data.... !!');
          else if(snapshot.hasData) {
            name= (snapshot.data.documents[0]['Name']);
            class1=(snapshot.data.documents[0]['class']);
            print(name);
            return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('NAME:'),
            new Text(snapshot.data.documents[0]['Name']),
            new Text('CLASS:'),
            new Text(snapshot.data.documents[0]['class']),
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
             onPressed: () {_insert();},
            ),
            RaisedButton(
              child: Text('show', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
          ],
        ),
      );
          }
        },
      )
    );
  }
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : name,
      DatabaseHelper.columnClass  : class1
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
  
}
