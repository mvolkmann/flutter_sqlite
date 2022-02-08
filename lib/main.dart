import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './dog.dart';

const title = 'My App';

void main() => runApp(
      MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Database database;

  @override
  void initState() {
    super.initState();

    dbSetup().then((db) {
      setState(() {
        database = db;
        demo();
      });
    });
  }

  Future<Database> dbSetup() async {
    WidgetsFlutterBinding.ensureInitialized();

    return openDatabase(
      join(await getDatabasesPath(), 'dog.db'),
      onCreate: (db, version) {
        return db.execute(
          'create table if not exists dogs('
          'id integer primary key autoincrement, age integer, breed text, name text)',
        );
      },
      // The version provides a path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  void demo() async {
    var comet = Dog(name: 'Comet', breed: 'Whippet', age: 1);
    await insertDog(database, comet);

    var dogs = await getDogs(database);
    print('main.dart demo: initial dogs = $dogs');

    comet.age += 1;
    await updateDog(database, comet);

    await deleteDog(database, comet.id);

    dogs = await getDogs(database);
    print('main.dart demo: final dogs = $dogs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Add content here.'),
          ],
        ),
      ),
    );
  }
}
