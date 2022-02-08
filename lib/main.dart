import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './dog.dart';
import './dog_service.dart';

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
  late DogService dogService;

  @override
  void initState() {
    super.initState();

    dbSetup().then((db) {
      setState(() {
        dogService = DogService(database: db);
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
      // The version can be used to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<Dog> createDog({
    required int age,
    required String breed,
    required String name,
  }) async {
    var dog = Dog(name: name, breed: breed, age: age);
    await dogService.create(dog);
    return dog;
  }

  void demo() async {
    await dogService.deleteAll();

    var maisey = await createDog(name: 'Maisey', breed: 'TWC', age: 12);
    await createDog(name: 'Ramsay', breed: 'NAID', age: 6);
    await createDog(name: 'Oscar', breed: 'GSP', age: 4);
    var comet = await createDog(name: 'Comet', breed: 'Whippet', age: 1);

    comet.age += 1;
    await dogService.update(comet);

    var dogs = await dogService.getAll();
    print('main.dart demo: initial dogs = $dogs');

    await dogService.delete(maisey.id!);

    dogs = await dogService.getAll();
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
