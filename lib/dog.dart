import 'dart:async';

import 'package:sqflite/sqflite.dart';

class Dog {
  int id;
  int age;
  String breed;
  String name;

  Dog({
    this.id = 0,
    required this.age,
    required this.breed,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'age': age, 'breed': breed, 'name': name};
  }

  // For debugging
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, breed: $breed, age: $age}';
  }
}

Future<void> insertDog(Database database, Dog dog) async {
  final db = database;
  await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Dog>> getDogs(Database database) async {
  final db = database;
  final List<Map<String, dynamic>> maps = await db.query('dogs');
  return List.generate(maps.length, (index) {
    var map = maps[index];
    return Dog(
      id: map['id'],
      age: map['age'],
      breed: map['breed'],
      name: map['name'],
    );
  });
}

Future<void> updateDog(Database database, Dog dog) async {
  final db = database;
  await db.update(
    'dogs',
    dog.toMap(),
    where: 'id = ?',
    // This prevents SQL injection.
    whereArgs: [dog.id],
  );
}

Future<void> deleteDog(Database database, int id) async {
  final db = database;
  await db.delete(
    'dogs',
    where: 'id = ?',
    whereArgs: [id],
  );
}
