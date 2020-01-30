import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(
  MaterialApp(
    home: Home(),
  )



);
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recovyBD() async {

    final pathBD = await getDatabasesPath();
    final localBD = join(pathBD, "dataBase2.db");

    var bd = await openDatabase(
      localBD,
      version: 1,
      onCreate: (db, dbRecentVersion){
        String sql = "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR(10), age INTEGER );";
        db.execute(sql);
        print(sql);
      }
    );
    return bd;

  }

  _save(String name, int age ) async {

    Map<String, dynamic> userData = {
      "nome": name,
      "age": age
    };
    Database bd = await _recovyBD();
    int id = await bd.insert("users", userData);
    print ("asalvo: "+id.toString());
    return id;
  }
  /*_select() async{
    String sql = "select * from users;";
    Database bd = await _recovyBD();
    bd.query(table)
  }*/
  @override
  Widget build(BuildContext context) {

    _recovyBD();
    _save("Murilo",18);
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Crud"),
        
      ),
      body: Center(
        child: Text("any"),

      ),
    );
    
  }
}

