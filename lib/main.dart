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
  final String tableName = "users";

  _recoveryBD() async {

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

  _insert(String name, int age ) async {

    Map<String, dynamic> userData = {
      "nome": name,
      "age": age
    };
    Database bd = await _recoveryBD();
    int id = await bd.insert("users", userData);
    print ("asalvo: "+id.toString());
    return id;
  }
  _listUserByName(String name) async{
    String sql = "select * from "+tableName+" WHERE nome like '"+name+"';";
    Database bd = await _recoveryBD();

    List users = await bd.rawQuery(sql);
    for (var user in users){
      print(
          "Id:"+ user['id'].toString()+
              "\nName: "+ user['nome']+
              "\nAge: "+ user['age'].toString()+
              "\n===========================\n"
      );
    }

    return users;
  }

  _listUserById(int id) async{
    String sql = "select * from "+tableName+" WHERE id = $id;";
    Database bd = await _recoveryBD();

    List users = await bd.rawQuery(sql);
    for (var user in users){
      print(
          "Id:"+ user['id'].toString()+
              "\nName: "+ user['nome']+
              "\nAge: "+ user['age'].toString()+
              "\n===========================\n"
      );
    }

    return users;
  }

  _listAllUsers() async{
    String sql = "select * from "+tableName+";";
    Database bd = await _recoveryBD();

    List users = await bd.rawQuery(sql);
    for (var user in users){
      print(
        "\nId:"+ user['id'].toString()+
          "\nName: "+ user['nome']+
          "\nAge: "+ user['age'].toString()
      );
    }

    return users;
  }
  _updateNameById(int id, String newName) async{
    String sql = "UPDATE "+tableName+" SET nome= ? WHERE id = ? ;";
    Database bd = await _recoveryBD();
    return bd.rawUpdate(sql, [newName,id]);
  }

  _deleteById(int id) async{
    String sql = "DELETE FROM "+tableName+"  WHERE id = ? ;";
    Database bd = await _recoveryBD();
    return bd.rawDelete(sql, [id]);

  }

  @override
  Widget build(BuildContext context) {

    _recoveryBD();
    _insert("Nome",18);
    _listUserByName("Nome");
    _updateNameById(14, "New Name").toString();
    _listUserByName("New Name");
    _deleteById(14).toString().toString();

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

